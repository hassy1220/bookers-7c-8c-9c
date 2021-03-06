class Book < ApplicationRecord
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  belongs_to:user
  has_many:favorites,dependent: :destroy
  has_many:like_user,through: :favorites,source: :user

  has_many:book_comments,dependent: :destroy
  # def get_profile_image
  #   (profile_image.attached?) ? profile_image : 'no_image.jpg'
  # end


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
