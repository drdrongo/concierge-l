class AddSeenToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :seen, :boolean, default: false
  end
end
