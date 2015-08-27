class AddPlantFieldsToInscription < ActiveRecord::Migration
  def change
    add_column :inscriptions, :plant_location, :text
    add_column :inscriptions, :plant_representation, :text
  end
end
