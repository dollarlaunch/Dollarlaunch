class Category < ApplicationRecord
  belongs_to :user
  has_many :campaigns, dependent: :destroy
  
end
