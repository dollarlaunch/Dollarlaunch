class ApplicationController < ActionController::Base
  
  def authorize_admin
    if current_user.admin == true
      return true
    else
      redirect_back(fallback_location: root_path, notice:'You are not authorize to access this page')
    end
  end
  
  def after_sign_in_path_for(resource)
    if session[:invitecampaign].present?
      Invite.create!(user_id: current_user.id, campaign_id: session[:invitecampaign])
    end
    dashboard_path(current_user)
  end
  
end