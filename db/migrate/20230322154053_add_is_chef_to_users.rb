class AddIsChefToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_chef, :boolean, default: false
  end
end
