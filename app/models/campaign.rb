class Campaign < ApplicationRecord
  
  belongs_to :user
  belongs_to :category
  validates_presence_of :title, :blurb, :description, :pledge_amount, :no_of_participants, :pledge_deadline, :location
  validates :title, :uniqueness => true
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  enum status: { Draft: 0, Launched: 1 }
  acts_as_votable
  has_many :campaignreviews, dependent: :destroy
  
  # Milestone Scenario
  has_many :milestones, dependent: :destroy
  accepts_nested_attributes_for :milestones, reject_if: :all_blank, allow_destroy: true
  
  # Project Champion Scenario
  has_many :projectchampions, dependent: :destroy
  enum projectchampionstatus: { Disabled: 0, Activated: 1 }
  has_attached_file :projectchampionvideo
  validates_attachment_content_type :projectchampionvideo, :content_type => ["video/mp4"]
  
  # Project Champion Images
  attr_accessor :projectchampionimages_array
  has_many :images, dependent: :destroy, as: :owner
  
  # Backer Scenario
  has_many :backers, dependent: :destroy
  
  # Risk and Challenge
  has_many :riskandchallenges, dependent: :destroy
  accepts_nested_attributes_for :riskandchallenges, reject_if: :all_blank, allow_destroy: true
  
  # FAQ's
  has_many :faqs, dependent: :destroy
  accepts_nested_attributes_for :faqs, reject_if: :all_blank, allow_destroy: true
  
  # Callbacks for the Images Creation and Updation
  after_create :create_images
  after_update :update_images
  
  private
  
    def create_images
      if self.projectchampionstatus == "Activated"
        self.projectchampionimages_array.each do |image|
          self.images.create(image: image)
        end
      end
    end
    
    def update_images
      if projectchampionimages_array.present?
        projectchampionimages_array.each do |image|
          images.create(image: image)
        end
      end
    end
  
end