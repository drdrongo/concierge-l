class AddDefaultValueToRequests < ActiveRecord::Migration[6.0]
  def change
    change_column :requests, :status, :string, default: "pending"
    change_column :time_requests, :status, :string, default: "pending"
    change_column :users, :host, :boolean, default: false
  end
end
