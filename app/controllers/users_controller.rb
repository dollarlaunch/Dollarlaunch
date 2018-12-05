class UsersController < ApplicationController
  
  before_action :authenticate_admin, only: [:index]
  before_action :set_user, only: [:dashboard, :profile]
  load_and_authorize_resource except: [:dashboard, :profile]
  
  def index
    @users = User.all
  end
  
  def dashboard
    if current_user.admin != true
      @campaigns = current_user.campaigns.limit(3)
    else
      @campaigns = Campaign.limit(1)
    end
  end
  
  def profile
  end
  
  private
  
    def authenticate_admin
      authorize_admin
    end
    
    def set_user
      @user = current_user
    end
    
end
