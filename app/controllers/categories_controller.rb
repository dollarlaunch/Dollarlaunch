class CategoriesController < ApplicationController
  
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_category_params, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  
  def index
    @categories = Category.all
  end
  
  def show
    @campaigns = @category.campaigns
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, flash: {success: 'Category Created Successfully'}
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @category.update(category_params)
      redirect_to @category, flash: {success: 'Category Updated Successfully'}
    else
      render 'edit'
    end
  end
  
  def destroy
    @category.destroy
    redirect_to categories_path, flash: {success: 'Category Deleted Successfully'}
  end
  
  private
    def set_category_params
      @category = Category.find(params[:id])
    end
    
    def category_params
      params.require(:category).permit(:name, :description, :user_id)
    end
    
end