class Milestone < ApplicationRecord
  
  belongs_to :campaign
  attr_accessor :images_array
  enum duration_type: [:Week, :Month]
  has_many :images, dependent: :destroy, as: :owner
  has_attached_file :video
  validates_attachment_content_type :video, :content_type => ["video/mp4"]
  enum status: { NotCompleted: 0, Completed: 1 }
  
  after_create :create_images
  after_update :update_images
  
  private
  
    def create_images
      self.images_array.each do |image|
        self.images.create(image: image)
      end
    end
  
    def update_images
      if images_array.present?
        images_array.each do |image|
          images.create(image: image)
        end
      end
    end
  
end