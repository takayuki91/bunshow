class Community < ApplicationRecord

  has_ancestry

  has_many :groups

end
