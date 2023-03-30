class CreateJoinTableMasterclassesCategories < ActiveRecord::Migration[7.0]
  def change
    create_join_table :masterclasses, :categories do |t|
      # t.index [:masterclass_id, :category_id]
      # t.index [:category_id, :masterclass_id]
    end
  end
end
