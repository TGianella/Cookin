class AddDescriptionToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :description, :text
  end

  def down
    remove_column :users, :description
  end
end
