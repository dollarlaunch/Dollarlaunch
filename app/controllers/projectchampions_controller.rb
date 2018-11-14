class ProjectchampionsController < ApplicationController
  
  before_action :authenticate_user!
  # before_action :set_projectchampion_params, except: [:index]
  
  def index
    @projectchampions = Projectchampion.all
  end
  
  def show
  end
  
  def create
    @projectchampion = Projectchampion.new(projectchampion_params)
    if @projectchampion.save
      redirect_to campaign_path(@projectchampion.campaign_id, anchor: 'nav-champion-tab')
    else
      render 'new'
    end
  end
  
  private
    
    def set_projectchampion_params
      @projectchampion = Projectchampion.find(params[:id])
    end
    
    def projectchampion_params
      params.require(:projectchampion).permit(:projectchampiontotalamount, :projectchampionpaidamount, :campaign_id, :user_id)
    end
  
end
