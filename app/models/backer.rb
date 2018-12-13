class Backer < ApplicationRecord
  
  belongs_to :user
  belongs_to :campaign
  has_many :backerinvoices, dependent: :destroy

end