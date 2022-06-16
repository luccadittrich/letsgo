class Chatroom < ApplicationRecord
  belongs_to :user
  belongs_to :followed, class_name: 'User'
  has_many :messages, dependent: :destroy
end
