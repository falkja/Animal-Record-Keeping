class CreateFlightObjectsFlightTrials < ActiveRecord::Migration
  def self.up
    create_table :flight_objects_flight_trials, :id => false do |t|
      t.integer :flight_object_id, :null => false
      t.integer :flight_trial_id, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :flight_objects_flight_trials
  end
end
