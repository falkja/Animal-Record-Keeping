class ModificationsForBatChanges < ActiveRecord::Migration
  def self.up
    change_column :cage_out_histories, :cage_in_history_id, :integer, { :null => true }
  end

  def self.down
    change_column :cage_out_histories, :cage_in_history_id, :integer, { :null => false }
  end
end
