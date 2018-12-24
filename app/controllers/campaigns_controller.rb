class CampaignsController < ApplicationController
  
  include ActionView::Helpers::NumberHelper  
  before_action :authenticate_me
  before_action :backer_params, only: [:show]
  before_action :set_campaign_params, only: [:show, :edit, :update, :destroy, :like]
  load_and_authorize_resource only: [:edit, :destroy, :new]
  
  def index
    if current_user.admin == true
      @campaigns = Campaign.all
    else
      @campaigns = current_user.campaigns
    end
  end
  
  def show
    @backer = Backer.new
    @projectchampion = Projectchampion.new
    @projectchampionsexist = @campaign.projectchampions.where(user_id: current_user.id, paymentstatus: true).first
    @backerexist = @campaign.backers.where(user_id: current_user.id, paymentstatus: true).first
    @campaignreview = Campaignreview.new
    @backers = @campaign.backers
    @reviews = @campaign.campaignreviews
    pledgeamountperperson
    eachmilestoneamount
  end
  
  def new
    @campaign = Campaign.new
  end
  
  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      Userbadge.create!(user_id:current_user.id,badge_id:6)
      redirect_to @campaign
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @campaign.update(campaign_params)
      redirect_to @campaign
    else
      render 'edit'
    end
  end
  
  def destroy
    @campaign.destroy

    redirect_to campaigns_path
  end
  
  def like
    respond_to do |format|
      if !current_user.liked? @campaign
        @campaign.liked_by current_user
      elsif current_user.liked? @campaign
        @campaign.unliked_by current_user
      end
    end
    format.html { redirect_to :back }
    format.js { render :layout => false }
  end
  
  private
  
    def set_campaign_params
      @campaign = Campaign.find(params[:id])
    end
    
    def campaign_params
      params.require(:campaign).permit(:image, :title, :blurb, :description, :location, :duration, :goal, :pledge_amount, :no_of_participants, :status, :pledge_deadline, :projectchampionminimumamount, :projectchampiontext, :projectchampionvideo ,:projectchampionstatus, :risksandchallenges, :faqs, :category_id, :user_id, :askfromcommunity, projectchampionimages_array:[], riskandchallenges_attributes:[:id, :description], faqs_attributes:[:id, :description], milestones_attributes: [:id, :title, :description, :duration_type, :duration_limit, :budget, :video, :_destroy, images_array:[]])
    end
    
    def authenticate_me
      if params[:referalcode].present?
        session[:referalcode] = params[:referalcode]
      end
      authenticate_user!
    end
    
    def pledgeamountperperson
      @pledgeamountperpersonininteger = @campaign.pledge_amount/@campaign.no_of_participants
      @pledgeamountperperson = number_with_precision(@pledgeamountperpersonininteger, precision: 2)
      return @pledgeamountperperson
    end
    
    def eachmilestoneamount
      @pledgeamountperpersonininteger = @campaign.pledge_amount/@campaign.no_of_participants
      @remainingamountininteger = @pledgeamountperpersonininteger - 1
      @remainingamountinstring = number_with_precision(@remainingamountininteger, precision: 2)
      @remainingamount = @remainingamountinstring.to_f
      @eachmilestoneamountininteger = @remainingamount/@campaign.milestones.count
      @eachmilestoneamount = number_with_precision(@eachmilestoneamountininteger, precision: 2)
      return @remainingamount, @eachmilestoneamount
    end
  
    def backer_params
      @campaign = Campaign.find(params[:id])
      if params[:paymentId].present? && params[:PayerID].present? && params[:token]
        paymentId = params[:paymentId]
        payerId = params[:PayerID]
        token = params[:token]
        @payment = Payment.find(paymentId)
        # Execute payment using payer_id obtained from query string following redirect
        if @payment.execute( :payer_id => payerId )
          logger.info "authorization executed successfully"
          # Capture auth id
          auth_id = @payment.transactions[0].related_resources[0].authorization.id;
        else
          logger.error @payment.error.inspect
        end
              
        authorization = Authorization.find(auth_id)
        capture = authorization.capture({
          :amount => {
            :currency => "USD",
            :total => "1.00"
          },
          :is_final_capture => false
        })
              
        if capture.success?
          logger.info "Capture[#{capture.id}]"
          # Backer Creation
          @backer = Backer.create!(pledgeamountperperson: pledgeamountperperson, eachmilestoneamount: eachmilestoneamount, paymentid: paymentId, payerid: payerId, token: token, paymentstatus: true, authorization: auth_id, user_id: current_user.id, campaign_id: @campaign.id)
          # Badges Creation
          if current_user.userbadges.count > 0
            current_user.userbadges.each do |badge|
              if badge.id != 2
                if current_user.backers.count >= 3
                  Userbadge.create(user_id: current_user.id, badge_id: 2)
                end
              end
              if badge.id != 3
                if current_user.backers.count >= 10
                  Userbadge.create(user_id: current_user.id, badge_id: 3)
                end
              end
            end
          else
            Userbadge.create!(user_id: current_user.id, badge_id: 1)
          end
          # Backer Invoice Creation
          Backerinvoice.create!(amount: capture.amount.total, captureid: capture.id ,backer_id: @backer.id)
        else
          logger.error capture.error.inspect
        end
      end
    end
    
end