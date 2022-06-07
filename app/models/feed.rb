class Feed < ApplicationRecord
  belongs_to :event
  has_many :posts
end
