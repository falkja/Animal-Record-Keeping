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

  #returns true or false depending if the last_done_date and current date indicate
  #if the task was completed on schedule
  #Note this is modulo week. So if we skip a week we won't know
  def done_by_schedule
    if last_done_date == nil #if the task has never been completed
      return false
    end
    
    today = Time.now.yday
    last_done_day = last_done_date.yday
    
    year_done = last_done_date.year
    while year_done < Date.today.year
      last_done_day = last_done_day - 365
      year_done = year_done + 1
    end
    
    if repeat == 0 #daily tasks
      if last_done_day < today #we will get problems at the beginning of a new year
          return false
      else
          return true
      end
    else #a particular day of the week
      post = self.find_post
      
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
      last_done_day = last_done_date.yday
      last_done_weekday = last_done_date.wday
      repeat_weekday = repeat - 1 #brings it in line with Time.wday convention
      
      done_year = last_done_date.year
      while done_year < Date.today.year
        last_done_day = last_done_day - 365
        done_year = done_year + 1
      end
      
      offset = today_weekday - repeat_weekday #offset is how many days apart today is from our deadline
      
      if internal_description == "feed" #feeding tasks can only be done on the deadline day
        jitter = 0
      else #everything else can be done one day ahead of schedule
        jitter = -1
      end
      
      if offset < jitter #because we always want to look back in time, unless you are within you're jitter
         offset = offset + 7
      end
      
      repeat_day = today - offset #repeat day is finally set, we will get problems if we are in the first week of a new year
      
      post = repeat_day + jitter
      
      return post
    end
end