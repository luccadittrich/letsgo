class Post < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many_attached :photos
  validates :content, presence: true
end
