class AutomatedFlightLogs < ActiveRecord::Migration
  def self.up
	add_column :species, :hibernating_start_month, :integer, :default => nil
	add_column :species, :hibernating_end_month, :integer, :default => nil
	add_column :flights, :exempt, :boolean, :default => nil
	add_column :flights, :exempt_type, :string, :default => nil
  end

  def self.down
    remove_column :species, :hibernating_start_month
	remove_column :species, :hibernating_end_month
	remove_column :flights, :exempt
	remove_column :flights, :exempt_type
  end
end
