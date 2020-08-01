class Amenity < ApplicationRecord
  has_many :hotel_amenities, dependent: :destroy
end
