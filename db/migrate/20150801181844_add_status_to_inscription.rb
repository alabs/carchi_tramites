class AddStatusToInscription < ActiveRecord::Migration
  def change
    add_column :inscriptions, :status, :integer
  end
end
