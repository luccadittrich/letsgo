class Post < ApplicationRecord
  belongs_to :feed
  belongs_to :user
  has_one_attached :photo
end
