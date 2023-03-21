class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.belongs_to :guest
      t.belongs_to :meeting
      t.timestamps
    end
  end
end