class AddEdTitleToInscription < ActiveRecord::Migration
  def change
    add_column :inscriptions, :ed_title, :integer
  end
end
