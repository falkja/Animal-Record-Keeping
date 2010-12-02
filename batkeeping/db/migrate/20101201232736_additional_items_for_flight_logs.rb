class AdditionalItemsForFlightLogs < ActiveRecord::Migration
  def self.up
	remove_column :flights, :exempt_type
	add_column :flights, :medical_problem_id, :integer, :default => nil
	add_column :flights, :protocol_id, :integer, :default => nil
	add_column :flights, :cage_id, :integer, :default => nil
	add_column :flights, :species_id, :integer, :default => nil
  end

  def self.down
	add_column :flights, :exempt_type, :string, :default => nil
	remove_column :flights, :medical_problem_id
	remove_column :flights, :protocol_id
	remove_column :flights, :cage_id
	remove_column :flights, :species_id
  end
end
