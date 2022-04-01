class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many:books,dependent: :destroy
  has_many:favorites,dependent: :destroy
  has_many:book_comments,dependent: :destroy

  has_many:follower,class_name: "Relationship" , foreign_key: "follower_id",dependent: :destroy
  has_many:followed,class_name: "Relationship" , foreign_key: "followed_id",dependent: :destroy

  has_many:followers,through: :follower,source: :followed
  has_many:followeds,through: :followed,source: :follower

  has_many:group_users,dependent: :destroy
  has_many:groups,through: :group_users

  has_many:user_rooms,dependent: :destroy
  has_many:chats,dependent: :destroy

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction,length:{ maximum: 50 }



  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
