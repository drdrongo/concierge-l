class Message < ApplicationRecord
  belongs_to :reservation, touch: true
  belongs_to :user
end
