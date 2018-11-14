class Campaign < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates_presence_of :title, :blurb, :description, :duration, :goal, :pledge_amount, :no_of_participants, :pledge_deadline, :location
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  enum status: { prelaunch: 0, launched: 1 }
  has_many :milestones, dependent: :destroy
  accepts_nested_attributes_for :milestones, reject_if: :all_blank, allow_destroy: true
  
  # Project Champion Scenario
  enum projectchampionstatus: { Disable: 0, Activate: 1 }
  has_attached_file :projectchampionvideo
  validates_attachment_content_type :projectchampionvideo, :content_type => ["video/mp4"]
  # Project Champion Images
  attr_accessor :projectchampionimages_array
  has_many :images, dependent: :destroy, as: :owner
  has_many :projectchampions, dependent: :destroy
  
  after_create :create_images
  def create_images
    if self.projectchampionstatus == "Activate"
      self.projectchampionimages_array.each do |image|
        self.images.create(image: image)
      end
    end
  end
  
  after_update :update_images
  def update_images
    images.destroy_all
    projectchampionimages_array.each do |image|
      images.create(image: image)
    end
  end
  
end