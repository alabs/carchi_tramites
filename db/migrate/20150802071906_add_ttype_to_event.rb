class AddTtypeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :ttype, :integer
  end
end
