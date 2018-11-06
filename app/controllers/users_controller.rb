class UsersController < ApplicationController
  
  before_action :authenticate_admin
  load_and_authorize_resource
  
  def index
    @users = User.all
  end
  
  private
    def authenticate_admin
      authorize_admin
    end
end
