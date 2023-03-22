class ChangeRecipeDifficultyType < ActiveRecord::Migration[7.0]
  def change
    change_column :recipes, :difficulty, :string
  end
end
