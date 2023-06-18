class Post < ApplicationRecord

  validates :explanation, presence:true, length:{ maximum:100 }

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :paragons, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy

  # 検索方法
  def self.looks(search, word)
    if search == "partial_match"
      @posts = Post.where("explanation LIKE?","%#{word}%" || "#{word}%" || "%#{word}")
    else
      @posts = Post.all
    end
  end

  def user_has_like?(user)
    likes.where(user_id: user.id).exists?
  end

  def user_has_paragon?(user)
    paragons.where(user_id: user.id).exists?
  end

  def user_has_bookmark?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  has_one_attached :post_image

  def get_post_image
    (post_image.attached?) ? post_image : 'no_image.jpg'
    # post_image.variant(resize_to_limit: [width, height]).processed
  end

end
