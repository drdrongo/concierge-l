class SetDefault < ActiveRecord::Migration[6.0]
  def change
    change_column :reservations, :arrival_time, :time, default: Time.new.change({hour: 15, minute: 0, second: 0})
    change_column :reservations, :departure_time, :time, default: Time.new.change({hour: 11, minute: 0, second: 0})
  end
end
