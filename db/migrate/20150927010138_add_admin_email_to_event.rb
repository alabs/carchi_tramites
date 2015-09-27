class AddAdminEmailToEvent < ActiveRecord::Migration
  def change
    add_column :events, :admin_email, :string
  end
end
