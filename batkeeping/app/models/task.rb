class Task < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :cage
  belongs_to :proposed_treatment

  def self.general_tasks
    find :all, :conditions => 'cage_id is null and proposed_treatment_id is null'
  end
  
  def self.cage_tasks #weighing
    find :all, :conditions => 'cage_id is not null'
  end
  
  def self.medical_tasks
    find :all, :conditions => 'proposed_treatment_id is not null'    
  end

  #returns true or false depending if the last_done_date and current date indicate
  #if the task was completed on schedule
  #Note this is modulo week. So if we skip a week we won't know
  def done_by_schedule
    today = Time.now.wday 
    last_done_day = last_done_date.wday
    repeat_day = repeat - 1 #brings it in line with Time.wday convention
    if repeat == 0 #daily        
        if last_done_day <=> today
            return false
        else
            return true
        end
    else #a particular day of the week
        return false #XXX
    end
    
    
  end
  
  
end
