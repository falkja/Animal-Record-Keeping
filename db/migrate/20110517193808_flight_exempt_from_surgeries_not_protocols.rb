class FlightExemptFromSurgeriesNotProtocols < ActiveRecord::Migration
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
    
    remove_column :bats, :surgery_time
    remove_column :bats, :surgery_note
    remove_column :bats, :surgery_type
  end

  def self.down
    drop_table :surgery_types
    drop_table :surgeries
    
    add_column :bats, :surgery_time, :datetime
    add_column :bats, :surgery_note, :text
    add_column :bats, :surgery_type, :string
  end
end
