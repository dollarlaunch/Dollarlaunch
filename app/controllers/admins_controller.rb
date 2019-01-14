class AdminsController < ApplicationController
  
  def index
    @users = User.all
    @campaigns = Campaign.all
  end
  
  def change_campaign_status
    @campaign = Campaign.find(params[:id])
    @campaign.status = 1
    @campaign.save
    redirect_to @campaign, flash: {success: 'Campaign Launched Successfully'}
  end
  
  def change_campaign_featuredstatus
    @campaign = Campaign.find(params[:id])
    @campaign.featuredstatus = true
    @campaign.save
    redirect_to @campaign, flash: {success: 'Campaign is now Feaetured'}
  end
  
  def change_campaign_allowmilestone
    @campaign = Campaign.find(params[:id])
    @campaign.allowmilestone = true
    if @campaign.save
      redirect_to @campaign, flash: {success: 'Campaign can now Start its Milestones'}
    else
      redirect_to @campaign, flash: {success: 'Error in Activating Milestone Start'}
    end
  end
  
end
