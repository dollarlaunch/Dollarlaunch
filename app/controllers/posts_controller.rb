class PostsController < ApplicationController
  
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post_params, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource except: [:index,:show]
  
  def index
    @posts = Post.all
  end
  
  def show
    @comment = Comment.new
    @comments = @post.comments
    @posts = Post.where.not(id: @post.id)
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post, flash: {success: 'Post Created Successfully'}
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @post.update(post_params)
      redirect_to @post, flash: {success: 'Post Updated Successfully'}
    else
      render 'edit'
    end
  end
  
  def destroy
    @post.destroy
    redirect_to posts_path, flash: {success: 'Post Deleted Successfully'}
  end
  
  private
  
    def set_post_params
      @post = Post.find(params[:id])
    end
    
    def post_params
      params.require(:post).permit(:image,:title,:description,:user_id)
    end

end
