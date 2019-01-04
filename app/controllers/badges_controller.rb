class BadgesController < ApplicationController
  
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_badge_param, only: [:show,:edit,:update,:destroy]
  load_and_authorize_resource except: [:socialsharebadge]
  skip_before_action :verify_authenticity_token
  
  def index
    @badges = Badge.all
  end
  
  def show
  end
  
  def new
    @badge = Badge.new
  end
  
  def create
    @badge = Badge.new(badge_params)
    if @badge.save
      redirect_to @badge, flash: {success: 'Badge Created Successfully'}
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @badge = Badge.update(badge_params)
      redirect_to @badge, flash: {success: 'Badge Updated Successfully'}
    else
      render 'edit'
    end
  end
  
  def destroy
    @badge.destroy
    redirect_to badges_path, flash: {success: 'Badge Deleted Successfully'}
  end
  
  def socialsharebadge
    @a = current_user.userbadges.where(badge_id: 5)
    if !@a.present?
      Userbadge.create!(user_id: current_user.id, badge_id: 5)
    end
    head :ok
  end
  
  private
    def set_badge_param
      @badge = Badge.find(params[:id])
    end
    
    def badge_params
      params.require(:badge).permit(:name,:user_id)
    end
    
end
