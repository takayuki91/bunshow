class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true

  # ゲストログイン時
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  has_many :posts, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :paragons, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  has_many :comments, dependent: :destroy

  has_many :active_relationships, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy
  has_many :follows, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followeds, through: :passive_relationships, source: :follow

  has_many :community_users
  has_many :communities, through: :community_users

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users, dependent: :destroy

  # public側の検索
  def self.looks(search, word)
    if search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%" || "#{word}%" || "%#{word}").where.not(is_deleted: true)
    else
      @user = User.where.not(is_deleted: true)
    end
  end

  # admin側の検索
  def self.find_records(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

  def is_followed_by?(user)
    passive_relationships.find_by(follow_id: user.id).present?
  end

  has_one_attached :profile_image

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image_user.jpg'
  end

end
