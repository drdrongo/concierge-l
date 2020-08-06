class AddCategoryToAmenities < ActiveRecord::Migration[6.0]
  def change
    add_column :amenities, :category, :string
  end
end
