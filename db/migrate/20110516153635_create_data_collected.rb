class CreateDataCollected < ActiveRecord::Migration
  def self.up
    create_table :data do |t|
      t.string :name
      
      t.timestamps
    end
    
    create_table :data_protocols, :id => false do |t|
      t.references :datum, :protocol, :null => false
    end
  end

  def self.down
    drop_table :data
    drop_table :data_protocols
  end
end
