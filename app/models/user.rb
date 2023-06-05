class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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

  def is_followed_by?(user)
    passive_relationships.find_by(follow_id: user.id).present?
  end

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true

  has_one_attached :profile_image

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

end
