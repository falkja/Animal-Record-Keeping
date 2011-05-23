class AddTimestampToBatChanges < ActiveRecord::Migration
  def self.up
    change_table :bat_changes do |t|
      t.timestamps
    end
    
    execute <<-SQL
      UPDATE bat_changes SET created_at = date;
    SQL
    execute <<-SQL
      UPDATE bat_changes SET updated_at = date;
    SQL
  end

  def self.down
    remove_column :bat_changes, :created_at
    remove_column :bat_changes, :updated_at
  end
end
