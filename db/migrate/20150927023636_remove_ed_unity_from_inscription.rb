class RemoveEdUnityFromInscription < ActiveRecord::Migration
  def up
    remove_column :inscriptions, :ed_unity
  end
  def down
    add_column :inscriptions, :ed_unity, :string
  end
end
