class AddIdToInscriptionsPlants < ActiveRecord::Migration
  def change
    add_column :inscriptions_plants, :id, :primary_key
  end
end
