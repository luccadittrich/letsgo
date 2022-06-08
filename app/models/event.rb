class Event < ApplicationRecord
  belongs_to :user
  has_many :feeds
  has_many :check_ins
  has_one_attached :photo
<<<<<<< HEAD
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
=======

  validates :date, :name, :local, :description, presence: true

>>>>>>> master
end
