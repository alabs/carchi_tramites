class CreateInstitutes < ActiveRecord::Migration
  def change
    create_table :institutes do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
