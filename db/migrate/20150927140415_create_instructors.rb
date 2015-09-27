class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
      t.references :event, index: true, foreign_key: true
      t.string :document_id
      t.text :full_name
      t.datetime :born_at
      t.integer :sex
      t.string :title
      t.string :phone
      t.string :phone_home
      t.text :address

      t.timestamps null: false
    end
  end
end
