class CampaignreviewsController < ApplicationController
  
  def create
    @campaignreview = Campaignreview.new(campaignreview_params)
    if @campaignreview.save
      @a = current_user.userbadges.where(badge_id: 4)
      if !@a.present?
        Userbadge.create!(user_id: current_user.id, badge_id: 4)
      end
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