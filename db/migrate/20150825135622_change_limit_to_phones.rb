class ChangeLimitToPhones < ActiveRecord::Migration
  def change
    change_column :inscriptions, :rep_phone_home, :integer, limit: 8
    change_column :inscriptions, :rep_phone_celular, :integer, limit: 8
    change_column :inscriptions, :rep_work_phone, :integer, limit: 8
    change_column :inscriptions, :phone, :integer, limit: 8
  end
end
