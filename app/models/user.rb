class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :perusals, dependent: :destroy
  has_many :readings, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships,
                       source: :followed
  has_many :followers, through: :passive_relationships,
                       source: :follower

  enum role: [:normal, :admin]

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def favorite book
    perusals.create book_id: book.id
  end

  def unfavorite book
    Perusal.find_by(user: self, book: book).destroy
  end

  def favorite? book
    Perusal.where(user: self, book: book).count > 0
  end

  def find_perusal book
    Perusal.find_by user: self, book: book
  end

  def read book, status
    record = Reading.find_or_initialize_by(user: self, book: book)
    record.update status: Reading.statuses[status]

    # if record = Reading.find_by(user: self, book: book)
    #   record.update status: Reading.statuses[status]
    # else
    #   readings.create book_id: book.id, status: Reading.statuses[status]
    # end
  end

  # def reading book
  #   if record = Reading.find_by(user: self, book: book)
  #     record.update status: 0
  #   else
  #     readings.create book_id: book.id, status: 0
  #   end
  # end

  # def read book
  #   if record = Reading.find_by(user: self, book: book)
  #     record.update status: 1
  #   else
  #     readings.create book_id: book.id, status: 1
  #   end
  # end

  def unread book
    Reading.find_by(user: self, book: book).destroy
  end

  def find_reading book
    Reading.find_by user: self, book: book
  end

  def reading? book
    Reading.where(user: self, book: book, status: 0).count > 0
  end

  def read? book
    Reading.where(user: self, book: book, status: 1).count > 0
  end
end
