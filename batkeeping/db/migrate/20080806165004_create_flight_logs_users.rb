class CreateFlightLogsUsers < ActiveRecord::Migration
  def self.up
    create_table :flight_logs_users, :id => false do |t|
      t.integer :flight_log_id, :null => false
      t.integer :user_id, :null => false
        
      t.timestamps
    end
  end

  def self.down
    drop_table :flight_logs_users
  end
end
