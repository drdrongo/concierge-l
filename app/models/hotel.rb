class Hotel < ApplicationRecord
  has_many :hotel_amenities, dependent: :destroy
  has_many :hotel_articles, dependent: :destroy
  has_many :reservations, dependent: :destroy
end
