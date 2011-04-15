class CreateAllowedBats < ActiveRecord::Migration
  def self.up
    create_table :allowed_bats do |t|
      t.integer :id
      t.integer :protocol_id
      t.integer :species_id
      t.integer :number

      t.timestamps
    end
  end

  def self.down
    drop_table :allowed_bats
  end
end
