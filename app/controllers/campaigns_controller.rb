class CampaignsController < ApplicationController
  
  before_action :authenticate_me
  before_action :backer_params, only: [:show]
  before_action :set_campaign_params, only: [:show, :edit, :update, :destroy]
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
  end
  
  def new
    @campaign = Campaign.new
  end
  
  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
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
  
  private
  
    def set_campaign_params
      @campaign = Campaign.find(params[:id])
    end
    
    def campaign_params
      params.require(:campaign).permit(:image, :title, :blurb, :description, :location, :duration, :goal, :pledge_amount, :no_of_participants, :status, :pledge_deadline, :projectchampionminimumamount, :projectchampiontext, :projectchampionvideo ,:projectchampionstatus, :category_id, :user_id, projectchampionimages_array:[], milestones_attributes: [:id, :title, :description, :duration_type, :duration_limit, :budget, :video, :_destroy, images_array:[]])
    end
    
    def authenticate_me
      if params[:referalcode].present?
        session[:referalcode] = params[:referalcode]
      end
      authenticate_user!
    end
    
    def backer_params
      @campaign = Campaign.find(params[:id])
      if @campaign.backers.present?
        @backers = @campaign.backers
        if params[:paymentId].present? && params[:PayerID].present? && params[:token]
          @backers.each do |backer|
            if backer.user.id == current_user.id
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
              else
                logger.error capture.error.inspect
              end
              backer.update_attributes(paymentid: paymentId, payerid: payerId, token: token, paymentstatus: true, authorization: auth_id)
            end
          end
        end
      end
    end
    
end