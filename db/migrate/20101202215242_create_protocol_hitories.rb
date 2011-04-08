class CreateProtocolHitories < ActiveRecord::Migration
  def self.up
    create_table :protocol_histories do |t|
      t.integer :bat_id
      t.integer :protocol_id
      t.datetime :date_removed

      t.timestamps
    end
	add_column :protocols, :flight_exempt, :boolean, :default => 0
  end

  def self.down
    drop_table :protocol_histories
	remove_column :protocols, :flight_exempt
  end
end
