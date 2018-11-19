class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :validatable
  
  has_many :categories
  has_many :campaigns, dependent: :destroy
  
  after_create :createreferalcode
  
  def createreferalcode
    @username = self.username
    @username = SecureRandom.urlsafe_base64(8)
    self.update(referalcode: @username) 
  end
  
end