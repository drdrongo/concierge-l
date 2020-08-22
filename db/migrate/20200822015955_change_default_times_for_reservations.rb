class ChangeDefaultTimesForReservations < ActiveRecord::Migration[6.0]
  def change
    change_column :reservations, :arrival_time, :time, default: Time.new(2000, 1, 1, 15)
    change_column :reservations, :departure_time, :time, default: Time.new(2000, 1, 1, 11)
  end
end
