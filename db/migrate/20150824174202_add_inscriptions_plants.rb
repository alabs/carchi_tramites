class AddInscriptionsPlants < ActiveRecord::Migration
  def change

    create_table :inscriptions_plants, id: false do |t|
      t.belongs_to :inscription, index: true
      t.belongs_to :plant, index: true
      t.integer :quantity
    end

  end
end
