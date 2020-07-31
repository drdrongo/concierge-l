class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :hotel, null: false, foreign_key: true
      t.date :check_in_date
      t.date :check_out_date
      t.time :arrival_time
      t.time :departure_time
      t.string :reservation_number
      t.integer :number_of_guests
      t.string :purpose
      t.string :channel
      t.integer :room_number

      t.timestamps
    end
  end
end
