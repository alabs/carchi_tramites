class RemoveReferencesToCategory < ActiveRecord::Migration
  def up
    remove_reference :events, :category
    remove_reference :emails, :category
  end
  def down
    add_reference :events, :category, index: true
    add_reference :emails, :category, index: true
  end
end
