class AddColumnSlugToRecipe < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :slug, :string
  end
end
