class HotelAmenity < ApplicationRecord
  belongs_to :hotel
  belongs_to :amenity
  has_many :requests, dependent: :destroy
end
