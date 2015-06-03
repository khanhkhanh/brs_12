class Book < ActiveRecord::Base
  belongs_to :category

  has_many :reviews, dependent: :destroy
  has_many :perusals, dependent: :destroy

  scope :order_by_created_at, -> {order created_at: :DESC}
end
