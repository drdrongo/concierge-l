class HotelArticle < ApplicationRecord
  belongs_to :hotel
  belongs_to :article
end
