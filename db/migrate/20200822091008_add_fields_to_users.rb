class AddFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :boolean
    add_column :users, :birthday, :date
    add_column :users, :description, :text
  end
end
