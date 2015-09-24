class AddOfficeToInscription < ActiveRecord::Migration
  def change
    add_column :inscriptions, :office, :text
  end
end
