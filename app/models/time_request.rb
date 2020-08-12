class TimeRequest < ApplicationRecord
  belongs_to :reservation, touch: true
end
