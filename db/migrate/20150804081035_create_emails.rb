class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.references :category, index: true, foreign_key: true
      t.integer :ttype
      t.string :subject
      t.text :body_html
      t.text :body_text

      t.timestamps null: false
    end
  end
end
