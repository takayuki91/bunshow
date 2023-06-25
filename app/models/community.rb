class Community < ApplicationRecord

  # Gem ancestryを導入のため
  has_ancestry
  
  has_many :community_users
  has_many :users, through: :community_users

end
