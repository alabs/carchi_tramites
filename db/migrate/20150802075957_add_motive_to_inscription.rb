class AddMotiveToInscription < ActiveRecord::Migration
  def change
    add_column :inscriptions, :motive, :text
  end
end
