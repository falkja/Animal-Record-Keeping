class AddBatChangesTable < ActiveRecord::Migration
  def self.up
    create_table :bat_changes do |table|
      table.column :bat_id, :integer, :null => false
      table.column :user_id, :integer
      table.column :cage_in_id, :integer
      table.column :cage_out_id, :integer
      table.column :owner_old_id, :integer
      table.column :owner_new_id, :integer
      table.column :medical_treatment_id, :integer
      table.column :note, :text
    end
  end

  def self.down
    drop_table :bat_changes
  end
end
