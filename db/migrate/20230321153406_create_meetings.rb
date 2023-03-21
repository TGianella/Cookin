class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.belongs_to :masterclass
      t.datetime :start_date
      t.string :zip_code
      t.integer :capacity
      t.timestamps
    end
  end
end
