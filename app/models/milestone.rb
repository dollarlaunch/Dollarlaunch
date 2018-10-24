class Milestone < ApplicationRecord
  belongs_to :campaign
  enum duration_type: [:Week, :Month]
  has_many_attached :images, dependent: :destroy
  def imagethumbnail id
    return self.images[id.to_i].variant(resize: '300x300!').processed
  end
  has_one_attached :clip, dependent: :destroy
  has_one_attached :thumbnail, dependent: :destroy
end