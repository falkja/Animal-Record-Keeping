class FlightExemptToSurgeriesNotProtocols < ActiveRecord::Migration
  def self.up
    create_table :surgery_types do |t|
      t.string :name
      
      t.timestamps
    end
    
    create_table :surgeries do |t|
      t.integer :surgery_type_id
      t.integer :bat_id
      t.datetime :time
      t.text :note
      t.integer :user_id
      
      t.timestamps
    end
    
    create_table :protocols_surgeries, :id => false do |t|
      t.integer :surgery_id
      t.integer :protocol_id
    end
    
    create_table :protocols_surgery_types, :id => false do |t|
      t.integer :surgery_type_id
      t.integer :protocol_id
    end
    
    create_table :flights_surgeries, :id => false do |t|
      t.integer :surgery_id
      t.integer :flight_id
    end
    add_column :flights, :has_surgery, :boolean, :default => 0
    
    #move the flight logs from protocols over to sugeries
    Flight.update_all("has_surgery = true", "protocol_exempt = true")
    
    remove_column :protocols, :flight_exempt
    remove_column :flights, :protocol_exempt
    
    remove_column :bats, :surgery_time
    remove_column :bats, :surgery_note
    remove_column :bats, :surgery_type
  end

  def self.down
    drop_table :surgery_types
    drop_table :surgeries
    
    drop_table :protocols_surgery_types
    drop_table :flights_surgeries
    drop_table :protocols_surgeries
    
    add_column :protocols, :flight_exempt, :boolean, :default => 0
    add_column :flights, :protocol_exempt, :boolean, :default => 0
    
    #move the flight logs from surgeries to protocols
    Flight.update_all("protocol_exempt = true", "has_surgery = true")
    
    remove_column :flights, :has_surgery
    add_column :bats, :surgery_time, :datetime
    add_column :bats, :surgery_note, :text
    add_column :bats, :surgery_type, :string
  end
end
