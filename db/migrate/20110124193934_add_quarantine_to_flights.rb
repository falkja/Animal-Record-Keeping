class AddQuarantineToFlights < ActiveRecord::Migration
  def self.up
    add_column :flights, :quarantine, :boolean
  end

  def self.down
    remove_column :flights, :quarantine
  end
end
