class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :validatable
  
  has_many :categories
  has_many :campaigns, dependent: :destroy
  has_many :backers, dependent: :destroy
  has_many :projectchampions, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :badges, dependent: :destroy
  has_many :userbadges, dependent: :destroy
  has_many :invites, dependent: :destroy
  acts_as_voter
  has_attached_file :avatar
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  
  after_create :createreferalcode
  
  def after_confirmation
    welcome_email
    UsermailerJob.perform_later(self)
  end
  
  def userreferalcodemacth
    @users = User.all
    i = 0
    @users.each do |user|
      if self.referalcode == user.referby
        i = i + 1
      end
    end
    return i
  end
  
  def userprojectchampioncount
    i = 0
    self.projectchampions.each do |projectchampion|
      if projectchampion.paymentstatus == true
        i = i + 1
      end
    end
    return i
  end
  
  private 
  
    def welcome_email
      UsermailerMailer.welcome_email(self).deliver
    end
    
    def createreferalcode
      @username = self.username
      @username = SecureRandom.urlsafe_base64(8)
      self.update(referalcode: @username) 
    end
  
end