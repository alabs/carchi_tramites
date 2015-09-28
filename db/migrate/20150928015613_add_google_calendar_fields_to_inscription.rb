class AddGoogleCalendarFieldsToInscription < ActiveRecord::Migration
  def change
    add_column :inscriptions, :google_calendar_id, :string
    add_column :inscriptions, :google_calendar_link, :string
  end
end
