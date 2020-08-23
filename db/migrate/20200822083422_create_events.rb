class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :datetime
      t.string :venue
      t.integer :capacity
      t.references :user, null: false, foreign_key: true
      t.string :category
      t.datetime :end_time


      t.timestamps
    end
  end
end
