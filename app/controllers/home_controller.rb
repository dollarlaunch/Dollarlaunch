class HomeController < ApplicationController
  
  def index
    @categories = Category.all
    @featuredcampaigns = Campaign.where(featuredstatus: 1).limit(2).order("created_at DESC")
    @campaigns = Campaign.where("status = ? AND featuredstatus = ?", "1", "0")
    @posts = Post.all().limit(3).order("created_at DESC")
  end
  
  def aboutus
  end
  
end