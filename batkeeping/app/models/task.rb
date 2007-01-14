class Task < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :cage
  belongs_to :proposed_treatment

  def self.general_tasks
    find :all, :conditions => 'cage_id is null and proposed_treatment_id is null'
  end
  
  def self.weighing_tasks #weighing
    find :all, :conditions => 'internal_description = "weigh"'
  end
  
  def self.medical_tasks
    find :all, :conditions => 'proposed_treatment_id is not null'    
  end

  def self.feeding_tasks #feeding
    find :all, :conditions => 'internal_description = "feed"'
  end

	def self.today
		tday = Time.now.wday + 1   
		find :all, :conditions => '(repeat_code = #{tday}) or (repeat_code = 0)' 
	end

	def self.feeding_tasks_today
		tday = Time.now.wday + 1   
		find :all, :conditions => "(repeat_code = #{tday}) or (repeat_code = 0) and (internal_description = 'feed')" 
	end
    
  #returns true or false depending if the last_done_date and current date indicate
  #if the task was completed on schedule
  #Note this is modulo week. So if we skip a week we won't know
  def done_by_schedule
    if last_done_date == nil #if the task has never been completed
      return false
    end
    
    today = Time.now.yday
    last_done_day = last_done_date.yday
    
    #to fix for the last done date being in the last year
    year_done = last_done_date.year
    while year_done < Date.today.year
      Date.leap?(year_done) ? last_done_day = last_done_day - 366 : last_done_day = last_done_day - 365
      year_done = year_done + 1
    end
    
    if repeat_code == 0 #daily tasks
      if last_done_day < today
        return false
      else
        return true
      end
    else #a particular day of the week
      post = self.find_post #gives a year day for which the task needs to be completed by
      
      if  (last_done_day >= post)
        return true
      else
        return false
      end
    end
      
  end
    
  def find_post
    today = Time.now.yday
    today_weekday = Time.now.wday
    
    repeat_weekday = repeat_code - 1 #to bring it in line with normal days of the week: 0-6
    
    offset = today_weekday - repeat_weekday #offset is how many days apart today is from our deadline
    
    if internal_description == "feed" #feeding tasks can only be done on the deadline day
      jitter = 0
    else #everything else can be done one day ahead of schedule
      jitter = -1
    end
    
    if offset < jitter #because we always want to look back in time, unless you are within your jitter
      offset = offset + 7
    end
    
    repeat_day = today - offset #repeat day is finally set, we will get problems if we are in the first week of a new year
    
    post = repeat_day + jitter
    
    return post
  end
end