class CreateFlightTrials < ActiveRecord::Migration
  def self.up
    create_table :flight_trials do |t|
      t.integer :flight_log_id, :null => false
      t.datetime :time
      t.integer :number, :null => false
      t.string :target_location
      t.string :distracter_location
      t.string :target_height
      t.string :distracter_height
      t.text :note
      t.integer :video_num
      t.integer :audio_num
      t.integer :array_num
      t.boolean :performance
      t.string :trial_sequence
      t.float :trial_duration
      t.string :ammount_fed

      t.timestamps
    end
  end

  def self.down
    drop_table :flight_trials
  end
end
