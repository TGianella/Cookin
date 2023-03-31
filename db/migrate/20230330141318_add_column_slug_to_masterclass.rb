class AddColumnSlugToMasterclass < ActiveRecord::Migration[7.0]
  def change
    add_column :masterclasses, :slug, :string
  end
end
