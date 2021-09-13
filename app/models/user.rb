class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


         has_many :post_images, dependent: :destroy
         has_many :post_comments, dependent: :destroy
         #お気に入り機能のアソシエーション
         has_many :favorites, dependent: :destroy

         #フォローフォロワー機能のアソシエーション
         has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
         has_many :followers, through: :reverse_of_relationships, source: :follower
         #被フォロー関係を通じて参照→followed_idをフォローしている人

         has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
         has_many :followings, through: :relationships, source: :followed
         #与フォロー関係を通じて参照→follower_idをフォローしている人

         attachment :profile_image
         
         
#フォローフォロワー機能のメソッド達         
def follow(user_id)
  relationships.create(followed_id: user_id)
end

def unfollow(user_id)
  relationships.find_by(followed_id: user_id).destroy
end

def following?(user)
  followings.include?(user)
end
#ーーーーーーーフォローフォロワー機能ここまでーーーーー

end