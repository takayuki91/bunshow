class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :post

  validates :comment, presence: true, length:{ maximum:100 }

  # admin側の検索
  def self.find_records(search, word)
    if search == "perfect_match"
      @comments = Comment.where("comment LIKE?", "#{word}")
    elsif search == "forward_match"
      @comments = Comment.where("comment LIKE?","#{word}%")
    elsif search == "backward_match"
      @comments = Comment.where("comment LIKE?","%#{word}")
    elsif search == "partial_match"
      @comments = Comment.where("comment LIKE?","%#{word}%")
    else
      @comments = Comment.all
    end
  end

end
