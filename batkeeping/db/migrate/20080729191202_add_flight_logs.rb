class AddFlightLogs < ActiveRecord::Migration
  def self.up
    create_table :flight_logs do |table|
      table.column :bat_id, :integer, :null => false
      table.column :date, :datetime, :null => false
      table.column :note, :text
      table.column :temperature, :float
      table.column :humidity, :float
      table.column :amount_fed, :string
    end
    
    create_table :flight_trials do |table|
      table.column :flight_log_id, :integer, :null => false
      table.column :time, :datetime
      table.column :number, :integer, :null => false
      table.column :target_location, :string
      table.column :distracter_location, :string
      table.column :target_height, :string
      table.column :distracter_height, :string
      table.column :note, :text
      table.column :video_number, :integer
      table.column :audio_number, :integer
      table.column :array_number, :integer
      table.column :performance, :string
      table.column :trial_sequence, :string
      table.column :trial_duration, :float
      table.column :amount_fed, :string
    end
    
    create_table :flight_logs_users, :id => false do |table|
      table.column :flight_log_id, :integer, :null => false
      table.column :user_id, :integer, :null => false
    end
    
    create_table :flight_objects do |table|
      table.column :name, :string, :null => false
    end
    
    create_table :flight_objects_flight_trials, :id => false do |table|
      table.column :flight_object_id, :integer, :null => false
      table.column :flight_trial_id, :integer, :null => false
    end
    
  end

  def self.down
    drop_table :flight_logs
    drop_table :flight_trials
    drop_table :flight_logs_users
    drop_table :flight_objects
    drop_table :flight_objects_flight_trials
  
  end
end
