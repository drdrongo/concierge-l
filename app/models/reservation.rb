class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :hotel
  has_many :time_requests, dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :messages, dependent: :destroy
end
