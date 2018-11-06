class Campaign < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates_presence_of :title, :blurb, :duration, :goal, :pledge_amount, :no_of_participants, :pledge_deadline, :location
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  enum status: { prelaunch: 0, launched: 1 }
  has_many :milestones, dependent: :destroy
  accepts_nested_attributes_for :milestones, reject_if: :all_blank, allow_destroy: true
end