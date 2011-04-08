class AddFieldnameToTablename < ActiveRecord::Migration
  def self.up
    add_column :cages, :flight_cage, :boolean, :default => 0, :null=> false
  end

  def self.down
    remove_column :cages, :flight_cage
  end
end
