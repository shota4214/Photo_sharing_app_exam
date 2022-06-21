class Picture < ApplicationRecord
  validates :content, presence: true
  mount_uploader :picture_image, PictureImageUploader
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
end
