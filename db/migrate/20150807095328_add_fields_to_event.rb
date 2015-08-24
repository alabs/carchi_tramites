class AddFieldsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :limit, :integer
    add_column :events, :starts_at, :date
    add_column :events, :ends_at, :date
    add_column :events, :price, :integer
  end
end
