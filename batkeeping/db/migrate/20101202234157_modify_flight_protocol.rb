class ModifyFlightProtocol < ActiveRecord::Migration
  def self.up
	remove_column :flights, :protocol_id
	add_column :flights, :protocol_exempt, :boolean, :default => 0
  end

  def self.down
    add_column :flights, :protocol_id, :integer, :default => nil
	remove_column :flights, :protocol_exempt
  end
end
