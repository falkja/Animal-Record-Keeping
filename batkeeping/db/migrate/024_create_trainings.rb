class CreateTrainings < ActiveRecord::Migration
  def self.up
    create_table :trainings do |t|
      t.integer :training_type_id
      t.integer :user_id
      t.date :date
      t.integer :user_trained_by_id
      t.text :note

      t.timestamps
    end
  end

  def self.down
    drop_table :trainings
  end
end
