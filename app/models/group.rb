class Group < ApplicationRecord

  belongs_to :owner, class_name: 'User'
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, source: :user

  validates :name, presence: true
  validates :introduction, presence: true

  has_one_attached :group_profile_image

  def get_group_profile_image
    (group_profile_image.attached?) ? group_profile_image : 'no_image.jpg'
  end
end
