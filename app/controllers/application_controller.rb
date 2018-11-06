class ApplicationController < ActionController::Base
  
  def authorize_admin
    if current_user.admin == true
      return true
    else
      redirect_back(fallback_location: root_path, notice:'You are not authorize to access this page')
    end
  end
  
end