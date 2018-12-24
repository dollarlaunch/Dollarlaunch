class CampaignreviewsController < ApplicationController
  
  def create
    @campaignreview = Campaignreview.new(campaignreview_params)
    if @campaignreview.save
      Userbadge.create!(user_id: current_user.id, badge_id: 4)
      redirect_to campaign_path(@campaignreview.campaign_id, anchor: 'nav-campaignreview')
    else
      render 'new'
    end
  end
  
  private
    def campaignreview_params
      params.require(:campaignreview).permit(:body, :user_id, :campaign_id)
    end
    
end