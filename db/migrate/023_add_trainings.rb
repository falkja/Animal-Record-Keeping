class AddTrainings < ActiveRecord::Migration
  def self.up
    create_table :trainings do |table|
      table.column :training_type_id, :integer, :null => false
      table.column :user_id, :integer, :null => false
      table.column :date, :date, :null => false
      table.column :user_trained_by_id, :integer, :null => false
      table.column :note, :text
    end
    
    create_table :training_types do |table|
      table.column :name, :string, :null => false
      table.column :description, :text
    end
    
	change_column("users", "job_type", "varchar(100)")
	
  end

  def self.down
    drop_table :trainings
    drop_table :training_types
  end
end
