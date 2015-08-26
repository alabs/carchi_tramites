class AddAdminEmailToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :admin_email, :string
  end
end
