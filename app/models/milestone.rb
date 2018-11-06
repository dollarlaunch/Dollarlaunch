class Milestone < ApplicationRecord
  belongs_to :campaign
  attr_accessor :images_array
  enum duration_type: [:Week, :Month]
  has_many :images, dependent: :destroy
  has_attached_file :video
  validates_attachment_content_type :video, :content_type => ["video.mov", "video/mp4"]
  
  after_create :create_images
  def create_images
    self.images_array.each do |image|
      self.images.create(image: image)
    end
  end
  
  after_update :update_images
  def update_images
    images.destroy_all
    images_array.each do |image|
      images.create(image: image)
    end
  end
  
end