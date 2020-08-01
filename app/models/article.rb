class Article < ApplicationRecord
  has_many :hotel_articles, dependent: :destroy
end
