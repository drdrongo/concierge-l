class CreateTimeRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :time_requests do |t|
      t.time :time
      t.boolean :check_in
      t.string :status
      t.references :reservation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
