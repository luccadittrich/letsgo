class Post < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_one_attached :photo
end
