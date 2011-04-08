class ModificationsForBatChanges < ActiveRecord::Migration
  def self.up
    change_column :cage_out_histories, :cage_in_history_id, :integer, { :null => true }
  end

  def self.down
    #creates problems once you have nils in the table
    #change_column :cage_out_histories, :cage_in_history_id, :integer, { :null => false }
  end
end
