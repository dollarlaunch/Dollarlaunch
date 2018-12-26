class Badge < ApplicationRecord
  belongs_to :user
  has_many :userbadges, dependent: :destroy
end
