class Event < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_by_name_and_category,
    against: %i[name category],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
  belongs_to :user
  has_many :posts
  has_many :check_ins
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  validates :date, :name, :address, :description, presence: true
end
