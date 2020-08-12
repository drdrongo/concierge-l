class Request < ApplicationRecord
  belongs_to :reservation, touch: true
  belongs_to :hotel_amenity
end
