class Task < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :cage
  belongs_to :proposed_treatment

  def self.general_tasks
    find :all, :conditions => 'cage_id is null and proposed_treatment_id is null'
  end
  
  def self.cage_tasks
    find :all, :conditions => 'cage_id is not null'
  end
  
  def self.medical_tasks
    find :all, :conditions => 'proposed_treatment_id is not null'    
  end
  
end
