class BatsFlown < ActiveRecord::Migration
  def self.up
	create_table :flights do |t|
		t.column :bat_id, :integer, :null => false
		t.column :date, :date
		t.column :user_id, :integer, :null => false
		t.column :note, :text
	end
	
	change_column("users", "job_type", "varchar(100)")
  end

  def self.down
	drop_table :flights
  end
end