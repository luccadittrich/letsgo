class User < ApplicationRecord
  has_many :follows, dependent: :destroy
  has_many :followeds, through: :follows
  has_one_attached :photo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def followers
    Follow.where(followed_id: id).map(&:user)
  end

  validates :username, presence: true, uniqueness: true
  validates :photo, :first_name, :last_name, :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
