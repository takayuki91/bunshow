class Group < ApplicationRecord

  belongs_to :owner, class_name: 'User'
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, source: :user

  validates :name, presence: true, length:{ maximum:20 }
  validates :introduction, presence: true, length:{ maximum:100 }
  
  # public側の検索
  def self.looks(search, word)
    if search == "partial_match"
      @group = Group.where("name LIKE?","%#{word}%" || "#{word}%" || "%#{word}")
    else
      @group = Group.all
    end
  end

  has_one_attached :group_profile_image

  def get_group_profile_image
    (group_profile_image.attached?) ? group_profile_image : 'no_image_group.jpg'
  end
  
end
