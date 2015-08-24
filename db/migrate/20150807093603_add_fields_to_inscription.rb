class AddFieldsToInscription < ActiveRecord::Migration
  def change
    add_column :inscriptions, :document_id, :string
    add_column :inscriptions, :sex, :integer
    add_column :inscriptions, :born_at, :date
    add_column :inscriptions, :address, :text
    add_column :inscriptions, :parroquia, :string
    add_column :inscriptions, :canton, :string
    add_column :inscriptions, :provincia, :string
  end
end
