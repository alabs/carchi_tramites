class CreateInscriptions < ActiveRecord::Migration
  def change
    create_table :inscriptions do |t|
      t.references :event, index: true
      t.string :first_name
      t.string :last_name
      t.integer :phone
      t.string :email

      t.timestamps null: false
    end
  end
end
