class BadgesController < ApplicationController
  
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_badge_param, only: [:show,:edit,:update,:destroy]
  load_and_authorize_resource except: [:index,:show]
  
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
      redirect_to @badge
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @badge = Badge.update(badge_params)
      redirect_to @badge
    else
      render 'edit'
    end
  end
  
  def destroy
    @badge.destroy
    redirect_to badges_path
  end
  
  private
    def set_badge_param
      @badge = Badge.find(params[:id])
    end
    
    def badge_params
      params.require(:badge).permit(:name,:user_id)
    end
    
end