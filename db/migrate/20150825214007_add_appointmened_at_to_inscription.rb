class AddAppointmenedAtToInscription < ActiveRecord::Migration
  def change
    add_column :inscriptions, :appointed_at, :datetime
  end
end
