class Event < ApplicationRecord
  belongs_to :user
  has_many :feeds
  has_many :check_ins
  has_one_attached :photo

  validates :date, :name, :local, :description, presence: true

end
