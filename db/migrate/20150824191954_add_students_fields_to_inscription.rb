class AddStudentsFieldsToInscription < ActiveRecord::Migration
  def change
    add_column :inscriptions, :ed_level, :string
    add_column :inscriptions, :ed_unity, :string
    add_column :inscriptions, :observations, :text
    add_column :inscriptions, :rep_document_id, :string
    add_column :inscriptions, :rep_full_name, :text
    add_column :inscriptions, :rep_sex, :integer
    add_column :inscriptions, :rep_title, :string
    add_column :inscriptions, :rep_phone_home, :integer
    add_column :inscriptions, :rep_phone_celular, :integer
    add_column :inscriptions, :rep_parroquia, :string
    add_column :inscriptions, :rep_canton, :string
    add_column :inscriptions, :rep_provincia, :string
    add_column :inscriptions, :rep_address, :text
    add_column :inscriptions, :rep_work_name, :string
    add_column :inscriptions, :rep_work_address, :text
    add_column :inscriptions, :rep_work_phone, :integer
  end
end
