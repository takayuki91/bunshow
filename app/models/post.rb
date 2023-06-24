class Post < ApplicationRecord

  validates :explanation, presence:true, length:{ maximum:100 }

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :paragons, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy

 # public側の検索
  def self.looks(search, word)
    if search == "partial_match"
      @posts = Post.where("explanation LIKE?","%#{word}%" || "#{word}%" || "%#{word}")
    else
      @posts = Post.all
    end
  end
  
  # admin側の検索
  def self.find_records(search, word)
    if search == "perfect_match"
      @posts = Post.where("explanation LIKE?", "#{word}")
    elsif search == "forward_match"
      @posts = Post.where("explanation LIKE?","#{word}%")
    elsif search == "backward_match"
      @posts = Post.where("explanation LIKE?","%#{word}")
    elsif search == "partial_match"
      @posts = Post.where("explanation LIKE?","%#{word}%")
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
    (post_image.attached?) ? post_image : 'no_image_post.jpg'
  end

end
