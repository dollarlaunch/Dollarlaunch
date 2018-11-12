class ProjectchampionsController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
  end
  
  def show
  end
  
  def create
    @projectchampion = Projectchampion.new(projectchampion_params)
    if @projectchampion.save
      redirect_to projectchampions_path
    else
      render 'new'
    end
  end
  
  private
  
    def set_projectchampion_params
      @projectchampion = Projectchampion.find(params[:id])
    end
    
    def projectchampion_params
      params.require(:projectchampion).permit(:projectchampionamount)
    end
  
end
