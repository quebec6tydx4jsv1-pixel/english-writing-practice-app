class AddApiUsageToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :daily_api_count, :integer, default: 0, null: false
    add_column :users, :monthly_api_count, :integer, default: 0, null: false
    add_column :users, :last_api_used_on, :date
    add_column :users, :last_api_month, :string
  end
end
