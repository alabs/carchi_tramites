class AddEventToEmail < ActiveRecord::Migration
  def change
    add_reference :emails, :event, index: true, foreign_key: true
  end
end
