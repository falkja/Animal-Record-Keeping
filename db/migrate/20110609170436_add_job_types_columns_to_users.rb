class AddJobTypesColumnsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :researcher, :boolean, :default => true
    User.update_all('researcher = false', "end_date is not null")
    
    add_column :users, :medical_care, :boolean, :default => false
    User.update_all('medical_care = true', "job_type regexp 'Medic'")
    
    add_column :users, :animal_care, :boolean, :default => false
    User.update_all('animal_care = true', "job_type regexp 'Anim'")
    
    add_column :users, :weekend_care, :boolean, :default => false
    User.update_all('weekend_care = true', "job_type regexp 'Weekend'")
    
    add_column :users, :administrator, :boolean, :default => false
    User.update_all('administrator = true', "job_type regexp 'Admin'")
    
    remove_column :users, :job_type
  end

  def self.down
    add_column :users, :job_type, :string, :default => nil
    
    #ideally we'd have a method to add the text back in to job_type, but I don't think it's important
    
    remove_column :users, :researcher
    remove_column :users, :medical_care
    remove_column :users, :animal_care
    remove_column :users, :weekend_care
    remove_column :users, :administrator
  end
end
