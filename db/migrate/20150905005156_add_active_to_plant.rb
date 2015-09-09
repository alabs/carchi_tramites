class AddActiveToPlant < ActiveRecord::Migration
  def change
    add_column :plants, :active, :boolean
  end
end
