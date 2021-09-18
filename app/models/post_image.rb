class PostImage < ApplicationRecord

  belongs_to :user
  attachment :image
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #いいね機能、ユーザーidが存在していればtrueなければfalseを
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end


  #検索機能実装
  def self.search(search,word)

    if search == "forward, word"
      @post_image = PostImage.where("post_title LIKE?","#{word}%")
      elsif search == "backward_match"
        @post_image = PostImage.where("post_title LIKE?","%#{word}")
        elsif search =="perfect_match"
        @post_image = PostImage.where(post_title: word) #完全一致
          elsif search == "partial_match"
          @post_image = PostImage.where("post_title LIKE?","%#{word}%") #部分一致
      else
        @post_image = PostImage.all
      end
    end
end