class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :events, through: :tickets
  has_one_attached :photo
  has_many :events_as_host, foreign_key: :user_id, class_name: "Event"

end
