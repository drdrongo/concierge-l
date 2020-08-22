class ChangeDefaultTimesForReservations < ActiveRecord::Migration[6.0]
  def change
    Time.zone = "Asia/Tokyo"
    change_column :reservations, :arrival_time, :time, default: Time.new(2000, 1, 1, 24)
    change_column :reservations, :departure_time, :time, default: Time.new(2000, 1, 1, 20)
  end
end
