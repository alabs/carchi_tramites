class ChangeDateFormatInInstructor < ActiveRecord::Migration
  def up
    change_column :instructors, :born_at, :date
  end

  def down
    change_column :instructors, :born_at, :datetime
  end
end
