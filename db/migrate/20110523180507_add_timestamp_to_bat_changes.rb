class AddTimestampToBatChanges < ActiveRecord::Migration
  def self.up
    change_table :bat_changes do |t|
      t.timestamps
    end
    
    BatChange.update_all('bat_changes.created_at = bat_changes.date')
    BatChange.update_all('bat_changes.updated_at = bat_changes.date')
  end

  def self.down
    remove_column :bat_changes, :created_at
    remove_column :bat_changes, :updated_at
  end
end
