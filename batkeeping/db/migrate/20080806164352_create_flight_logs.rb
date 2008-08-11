class CreateFlightLogs < ActiveRecord::Migration
  def self.up
    create_table :flight_logs do |t|
      t.integer :bat_id, :null => false
      t.datetime :date, :null => false
      t.text :note
      t.float :temperature
      t.float :humidity
      t.string :amount_fed

      t.timestamps
    end
  end

  def self.down
    drop_table :flight_logs
  end
end
