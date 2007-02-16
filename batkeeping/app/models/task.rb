class Task < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :cage
  belongs_to :proposed_treatment
  has_many :task_histories, :order => 'date_done'

	@@current_user = nil

  def self.general_tasks
    find :all, :conditions => 'internal_description is null and date_ended is null', :order => 'repeat_code'
  end
  
  def self.general_tasks_today
		tday = Time.now.wday + 1   
		find :all, :conditions => "((repeat_code = #{tday}) or (repeat_code = 0)) and (internal_description is null) and date_ended is null", :order => 'repeat_code'
	end
  
  def self.general_tasks_not_today
		tday = Time.now.wday + 1   
		find :all, :conditions => "((repeat_code != #{tday}) and (repeat_code != 0)) and (internal_description is null) and date_ended is null", :order => 'repeat_code'
	end
  
  def self.weighing_tasks #weighing
    find :all, :conditions => 'internal_description = "weigh" and date_ended is null', :order => 'repeat_code'
  end
  
  def self.weighing_tasks_today
		tday = Time.now.wday + 1   
		find :all, :conditions => "((repeat_code = #{tday}) or (repeat_code = 0)) and (internal_description = 'weigh') and date_ended is null", :order => 'repeat_code'
	end
  
  def self.weighing_tasks_not_today
		tday = Time.now.wday + 1   
		find :all, :conditions => "((repeat_code != #{tday}) and (repeat_code != 0)) and (internal_description = 'weigh') and date_ended is null", :order => 'repeat_code'
	end
  
  def self.medical_tasks
    find :all, :conditions => 'proposed_treatment_id is not null and date_ended is null', :order => 'repeat_code'
  end

  def self.feeding_tasks #feeding
    find :all, :conditions => 'internal_description = "feed" and date_ended is null', :order => 'repeat_code'
  end

	def self.feeding_tasks_today
		tday = Time.now.wday + 1   
		find :all, :conditions => "((repeat_code = #{tday}) or (repeat_code = 0)) and (internal_description = 'feed') and date_ended is null", :order => 'repeat_code'
	end

	def self.feeding_tasks_not_today
		tday = Time.now.wday + 1   
		find :all, :conditions => "((repeat_code != #{tday}) and (repeat_code != 0)) and (internal_description = 'feed') and date_ended is null", :order => 'repeat_code'
	end

	def self.today
		tday = Time.now.wday + 1   
		find :all, :conditions => '(repeat_code = #{tday}) or (repeat_code = 0) and date_ended is null', :order => 'repeat_code'
	end
    
  #returns true or false depending if the last_done_date and current date indicate
  #if the task was completed on schedule
  #Note this is modulo week. So if we skip a week we won't know
  def done_by_schedule
    if self.last_done_date == nil #if the task has never been completed, then it certainly hasn't been done by schedule
      return false
    end
    
    today = Time.now.yday
    last_done_day = self.last_done_date.yday
    
    #to fix for the last done date being in the last year
    year_done = self.last_done_date.year
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
    if repeat_code == 0 #our deadline is today for all daily tasks
      repeat_weekday = today_weekday
    else
      repeat_weekday = repeat_code - 1 #to bring it in line with normal days of the week: 0-6
    end
    
    offset = today_weekday - repeat_weekday #offset is how many days apart today is from our deadline
    
    
    if offset < jitter #because we always want to look back in time, unless you are within your jitter
      offset = offset + 7
    end
    
    repeat_day = today - offset #repeat day is finally set, we will get problems if we are in the first week of a new year
    
    post = repeat_day + jitter
    
    return post
  end
  
  def deactivate
    self.date_ended = Time.now
    self.save
  end
  
  def done
    self.done_with_date(Time.now)
  end
  
  def done_with_date(date_done)
    if (date_done.yday >= self.find_post) && (date_done.yday <= (self.find_post - self.jitter))
      task_history = TaskHistory.new
      task_history.task = self
      task_history.date_done = date_done
      task_history.user_id = @@current_user
      task_history.save
    end
  end
  
  def Task.set_current_user(user)
	  @@current_user = user
  end
    
	#this function returns the last done date for a particular task.  if converted into a mysql query it might be faster
  def last_done_date
    if self.task_histories.length == 0
      return nil
    else
      return self.task_histories[0].date_done
    end
  end
end