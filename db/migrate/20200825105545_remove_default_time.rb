class RemoveDefaultTime < ActiveRecord::Migration[6.0]
  def change
    change_column_default :reservations, :arrival_time, nil
    change_column_default :reservations, :departure_time, nil
  end
end
