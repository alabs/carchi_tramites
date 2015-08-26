class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.integer :dow
      t.integer :starts_hour
      t.integer :ends_hour
      t.integer :time

      t.timestamps null: false
    end
  end
end
