class CreateFlightObjects < ActiveRecord::Migration
  def self.up
    create_table :flight_objects do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :flight_objects
  end
end
