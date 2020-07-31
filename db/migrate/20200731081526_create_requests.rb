class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.references :reservation, null: false, foreign_key: true
      t.references :hotel_amenity, null: false, foreign_key: true
      t.string :status
      t.integer :quantity

      t.timestamps
    end
  end
end
