class AddTimestampsToInscriptionsPlants < ActiveRecord::Migration
  def change
    change_table :inscriptions_plants do |t|
      t.timestamps
    end
  end
end
