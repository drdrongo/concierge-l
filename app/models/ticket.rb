class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :status, inclusion: { in: %w[pending accepted declined] }
end
