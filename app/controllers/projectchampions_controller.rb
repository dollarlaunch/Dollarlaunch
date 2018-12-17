class ProjectchampionsController < ApplicationController
  
  before_action :authenticate_user!, except: [:hook]
  protect_from_forgery except: [:hook]
  # before_action :set_projectchampion_params, except: [:index]
  
  def index
    @projectchampions = Projectchampion.all
  end
  
  def show
  end
  
  def create
    @projectchampion = Projectchampion.new(projectchampion_params)
    if @projectchampion.save
      redirect_to @projectchampion.paypal_url(campaign_path(@projectchampion.campaign_id, anchor: 'nav-champion-tab'))
    end
  end
  
  def hook
    params.permit! # Permit all Paypal input params
    status = params[:payment_status]
    if status == "Completed"
      @projectchampion = Projectchampion.find(params[:item_number])
      @projectchampion.update_attributes(paymentstatus: true)
      Userbadge.create!(user_id:current_user.id,badge_id:1)
    end
    head :ok
  end
  
  private
    
    def set_projectchampion_params
      @projectchampion = Projectchampion.find(params[:id])
    end
    
    def projectchampion_params
      params.require(:projectchampion).permit(:projectchampiontotalamount, :projectchampionpaidamount, :campaign_id, :user_id)
    end
    
end