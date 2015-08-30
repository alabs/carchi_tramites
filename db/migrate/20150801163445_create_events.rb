class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.references :category, index: true

      t.timestamps null: false
    end
  end
end
