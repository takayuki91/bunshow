class Post < ApplicationRecord

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :paragons, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :explanation, presence:true, length:{ maximum:200 }

  def user_has_like?(user)
    likes.where(user_id: user.id).exists?
  end

  def user_has_paragon?(user)
    paragons.where(user_id: user.id).exists?
  end

  def user_has_bookmark?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  has_many_attached :post_images

  def get_post_images
    (post_images.attached?) ? post_images : 'no_image.jpg'
  end

end
