class CreateProtocols < ActiveRecord::Migration
  def self.up
    create_table :protocols do |t|
      t.string :title
      t.string :number
      t.date :start_date
      t.date :end_date
      t.boolean :husbandry

      t.timestamps
    end
	
    create_table :bats_protocols, :id => false do |t|
      t.integer :bat_id
      t.integer :protocol_id
    end
	
  end

  def self.down
    drop_table :protocols
	drop_table :bats_protocols
  end
end
