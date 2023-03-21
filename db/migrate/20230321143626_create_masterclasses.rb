class CreateMasterclasses < ActiveRecord::Migration[7.0]
  def change
    create_table :masterclasses do |t|
      t.string :title
      t.text :description
      t.integer :duration
      t.float :price
      t.timestamps
      t.belongs_to :chef
    end
  end
end
