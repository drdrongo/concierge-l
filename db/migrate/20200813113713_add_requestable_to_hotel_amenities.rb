class AddRequestableToHotelAmenities < ActiveRecord::Migration[6.0]
  def change
    add_column :hotel_amenities, :requestable, :boolean
  end
end
