class AdminsController < ApplicationController
  
  def index
    @users = User.all
    @campaigns = Campaign.all
  end
  
  def change_campaign_status
    @campaign = Campaign.find(params[:id])
    @campaign.status = 1
    @campaign.save
    redirect_to @campaign
  end
  
end
