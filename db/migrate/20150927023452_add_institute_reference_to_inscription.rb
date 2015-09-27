class AddInstituteReferenceToInscription < ActiveRecord::Migration
  def change
    add_reference :inscriptions, :institute, index: true, foreign_key: true
  end
end
