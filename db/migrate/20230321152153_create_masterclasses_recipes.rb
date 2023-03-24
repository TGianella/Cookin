class CreateMasterclassesRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :masterclasses_recipes do |t|
      t.belongs_to :recipe
      t.belongs_to :masterclass
      t.timestamps
    end
  end
end
