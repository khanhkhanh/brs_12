class Book < ActiveRecord::Base
  belongs_to :category
  
  has_many :reviews, dependent: :destroy
  has_many :perusals, dependent: :destroy

  mount_uploader :picture, PictureUploader
end
