class Post < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many_attached :photos
  validates :content, presence: true
  belongs_to :post, class_name: "Post", optional: true
  has_many :posts
end
