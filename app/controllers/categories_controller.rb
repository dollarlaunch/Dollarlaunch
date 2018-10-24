class CategoriesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_category_params, only: [:show, :edit, :update, :destroy]
  
  def index
  end
  
  def show
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @category.update(category_params)
      redirect_to @category
    else
      render 'edit'
    end
  end
  
  def destroy
    @category.destroy
    redirect_to categories_path
  end
  
  private
    def set_category_params
      @category = Category.find(params[:id])
    end
    
    def category_params
      params.require(:category).permit(:name, :user_id)
    end
    
end
