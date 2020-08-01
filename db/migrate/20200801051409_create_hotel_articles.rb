class CreateHotelArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :hotel_articles do |t|
      t.references :hotel, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
