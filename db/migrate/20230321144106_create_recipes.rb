class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :content
      t.integer :duration
      t.integer :difficulty
      t.belongs_to :chef
      t.timestamps
    end
  end
end
