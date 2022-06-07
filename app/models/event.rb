class Event < ApplicationRecord
  belongs_to :user
  has_many :feeds
  has_many :check_ins
end
