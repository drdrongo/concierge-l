class Amenity < ApplicationRecord
  has_many :hotel_amenities, dependent: :destroy
  has_many :hotels, through: :hotel_amenities
end
