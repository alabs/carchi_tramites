class AddFieldsToInstitute < ActiveRecord::Migration
  def change
    add_column :institutes, :principal_name, :string
    add_column :institutes, :phone, :string
    add_column :institutes, :address, :string
    add_column :institutes, :parroquia, :string
    add_column :institutes, :canton, :string
    add_column :institutes, :provincia, :string
    add_column :institutes, :foundated_at, :date
    add_column :institutes, :ttype, :integer
    add_column :institutes, :students_number, :integer
  end
end
