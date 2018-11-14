class CampaignsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_campaign_params, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource only: [:edit, :destroy]
  
  def index
    if current_user.admin == true
      @campaigns = Campaign.all
    else
      @campaigns = current_user.campaigns
    end
  end
  
  def show
    @projectchampion = Projectchampion.new
    @projectchampionsexist = @campaign.projectchampions
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
    
end