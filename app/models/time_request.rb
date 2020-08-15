class TimeRequest < ApplicationRecord
  belongs_to :reservation, touch: true
  accepts_nested_attributes_for :reservation
end
