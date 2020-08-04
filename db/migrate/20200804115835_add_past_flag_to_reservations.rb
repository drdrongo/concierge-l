class AddPastFlagToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :past, :boolean, default: false
  end
end
