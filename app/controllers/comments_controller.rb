class CommentsController < ApplicationController

  before_action :authenticate_me
  before_action :set_comment_params, except: [:create]
  before_action :set_post_params, except: [:edit, :destroy, :update]
  load_and_authorize_resource only: [:edit, :destroy]
  
  def create
    @comment = Comment.new(comment_params)
     respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post) }
        format.js
      else
        format.html { render :new }
      end
    end
  end
  
  def edit
    @post = @comment.post
  end
  
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_path(@post) }
        format.js{}
      else
        format.html { render :edit }
      end
    end
  end
  
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.js
    end
  end
  
  private
  
  def set_post_params
    @post = Post.find(params[:comment][:post_id])
  end
  
  def set_comment_params
    @comment = Comment.find(params[:id])
  end
  
  def comment_params
    params.require(:comment).permit(:body, :post_id, :user_id)
  end
  
  def authenticate_me
    if !user_signed_in?
      flash[:warning] = "You need to log in before you can take part in discussions."
      redirect_back(fallback_location: root_url)
    end
  end

end
