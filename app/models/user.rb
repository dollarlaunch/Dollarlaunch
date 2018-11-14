class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :validatable
  
  has_many :categories, dependent: :destroy
  has_many :campaigns, dependent: :destroy
end