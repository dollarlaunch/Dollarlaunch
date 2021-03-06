class HomeController < ApplicationController
  
  def index
    @categories = Category.all
    @featuredcampaigns = Campaign.where(featuredstatus: 1).limit(2).order("created_at DESC")
    @campaigns = Campaign.where("status = ? AND featuredstatus = ?", "1", "0")
    @posts = Post.all().limit(3).order("created_at DESC")
  end
  
  def aboutus
  end
  
  def featuredcampaigns
    @campaigns = Campaign.where(featuredstatus: 1).order("created_at DESC")
  end
  
  def searchcampaigns
    if params[:category].present? or params[:search].present?
      if params[:search].present?
        @campaigns = Campaign.search(params[:search])
        @status = "Searched"
      elsif params[:category].present?
        @campaigns = Campaign.where(status: "Launched", category_id: Category.find_by_name(params[:category]).id).includes(:category).order('created_at DESC')
        @status = params[:category]
      end
    else
      @campaigns = Campaign.where(status: "Launched").order('created_at DESC').includes(:category)
      @status = "All Campaigns"
    end
  end
  
  def inviteemail
    if params[:email].present?
      @campaign = params[:campaign_id]
      @email = params[:email]
      @user = params[:campaign_user]
      @referalcode = params[:campaign_user_referalcode]
      @url = campaign_url(@campaign, referalcode: @referalcode, invitecampaign: @campaign)
      UsermailerMailer.inviteemail_email(@email, @user, @url).deliver
      redirect_to campaign_path(@campaign), flash: {success: 'Email Sent Successfully'}
    else
      redirect_to campaign_path(@campaign), flash: {error: 'Email Sending Failed'}
    end
  end
  
end