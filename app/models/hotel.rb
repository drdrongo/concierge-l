class Hotel < ApplicationRecord
  has_many :hotel_amenities, dependent: :destroy
  has_many :hotel_articles, dependent: :destroy
  has_many :articles, through: :hotel_articles
  has_many :reservations, dependent: :destroy
  has_many :amenities, through: :hotel_amenities
end
