class User < ApplicationRecord
  has_many :follows, dependent: :destroy
  has_many :followeds, through: :follows
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def followers
    Follow.where(followed_id: id).map(&:user)
  end
end
