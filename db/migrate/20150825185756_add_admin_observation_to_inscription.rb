class AddAdminObservationToInscription < ActiveRecord::Migration
  def change
    add_column :inscriptions, :admin_observation, :text
  end
end
