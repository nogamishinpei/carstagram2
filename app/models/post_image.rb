class PostImage < ApplicationRecord
  
  belongs_to :user
  attachment :image
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  #いいね機能、ユーザーidが存在していればtrueなければfalseを
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end