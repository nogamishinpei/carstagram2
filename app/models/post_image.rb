class PostImage < ApplicationRecord

  belongs_to :user
  attachment :image
  #コメントのアソシエーション
  has_many :post_comments, dependent: :destroy
  #お気に入りのアソシエーション
  has_many :favorites, dependent: :destroy
  #タグ付けのアソシエーション
  has_many :tag_relationships, dependent: :destroy
  has_many :tags, through: :tag_relationships
  
  #バリデーション
  validates :post_title, presence: true
  validates :caption, presence: true, length: {minimum: 5, maximum: 200}
  




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
    
  def save_tags(savepost_image_tags)
    savepost_image_tags.each do |new_name|
      post_image_tag = Tag.find_or_create_by(name: new_name)
      self.tags << post_image_tag
    end
  end
end