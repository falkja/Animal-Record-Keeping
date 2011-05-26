class AddMonitorVaccinationToBats < ActiveRecord::Migration
  def self.up
    add_column :bats, :monitor_vaccination, :boolean, :default => true
  end

  def self.down
    remove_column :bats, :monitor_vaccination
  end
end
