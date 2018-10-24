class Campaign < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_one_attached :image, dependent: :destroy
  def thumbnail
    return self.image.variant(resize: '400x300!').processed
  end
  enum status: [ :Prelaunch, :Launched ]
  has_many :milestones, dependent: :destroy
  accepts_nested_attributes_for :milestones, reject_if: :all_blank, allow_destroy: true
end
