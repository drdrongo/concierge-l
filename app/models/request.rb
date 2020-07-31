class Request < ApplicationRecord
  belongs_to :reservation
  belongs_to :hotel_amenity
end
