class Task < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :cage
  belongs_to :medical_treatment
	belongs_to :room
  has_many :task_histories, :order => 'date_done desc'
	has_many :task_census

	@@current_user = nil

  def self.general_tasks
    find :all, :conditions => '(medical_treatment_id is null) and (cage_id is null) and date_ended is null', :order => 'repeat_code'
  end
  
  def self.general_tasks_today
		tday = Time.now.wday + 1
		find :all, :conditions => "((repeat_code = #{tday}) or (repeat_code = 0)) and (medical_treatment_id is null) and (cage_id is null) and date_ended is null", :order => 'repeat_code'
	end
  
  def self.general_tasks_not_today
		tday = Time.now.wday + 1
		find :all, :conditions => "((repeat_code != #{tday}) and (repeat_code != 0)) and (medical_treatment_id is null) and (cage_id is null) and date_ended is null", :order => 'repeat_code'
	end
  
	def self.animal_care_user_general_tasks
		find :all, :conditions => '(medical_treatment_id is null) and (cage_id is null) and date_ended is null and animal_care = 1', :order => 'repeat_code'
	end
	
	def self.animal_care_user_general_tasks_today
		tday = Time.now.wday + 1
		find :all, :conditions => "((repeat_code = #{tday}) or (repeat_code = 0)) and (medical_treatment_id is null) and (cage_id is null) and date_ended is null and animal_care = 1", :order => 'repeat_code'
	end
	
	def self.animal_care_user_general_tasks_not_today
		tday = Time.now.wday + 1
		find :all, :conditions => "((repeat_code != #{tday}) and (repeat_code != 0)) and (medical_treatment_id is null) and (cage_id is null) and date_ended is null and animal_care = 1", :order => 'repeat_code'
	end

  def self.feeding_tasks
    find :all, :conditions => 'internal_description = "feed" and date_ended is null', :order => 'repeat_code, title'
  end

	def self.feeding_tasks_today
		tday = Time.now.wday + 1
		find :all, :conditions => "((repeat_code = #{tday}) or (repeat_code = 0)) and (internal_description = 'feed') and date_ended is null", :order => 'repeat_code, title'
	end

	def self.feeding_tasks_not_today
		tday = Time.now.wday + 1
		find :all, :conditions => "((repeat_code != #{tday}) and (repeat_code != 0)) and (internal_description = 'feed') and date_ended is null", :order => 'repeat_code, title'
	end

	def self.animal_care_user_feeding_tasks
		find :all, :conditions => 'internal_description = "feed" and date_ended is null and animal_care = 1', :order => 'repeat_code, title'
	end
	
	def self.animal_care_user_feeding_tasks_today
		tday = Time.now.wday + 1
		find :all, :conditions => "((repeat_code = #{tday}) or (repeat_code = 0)) and (internal_description = 'feed') and date_ended is null and animal_care = 1", :order => 'repeat_code, title'
	end
	
	def self.animal_care_user_feeding_tasks_not_today
		tday = Time.now.wday + 1
		find :all, :conditions => "((repeat_code != #{tday}) and (repeat_code != 0)) and (internal_description = 'feed') and date_ended is null and animal_care = 1", :order => 'repeat_code, title'
	end
	
  def self.medical_tasks
    find :all, :conditions => 'medical_treatment_id is not null and date_ended is null', :order => 'repeat_code'
  end
  
  def self.medical_tasks_today
	  tday = Time.now.wday + 1
	  find :all, :conditions => "((repeat_code = #{tday}) or (repeat_code = 0)) and (internal_description = 'medical') and date_ended is null", :order => 'repeat_code'
  end

  def self.medical_tasks_not_today
	  tday = Time.now.wday + 1
	  find :all, :conditions => "((repeat_code != #{tday}) and (repeat_code != 0)) and (internal_description = 'medical') and date_ended is null", :order => 'repeat_code'
  end

	def self.medical_user_tasks
		find :all, :conditions => 'medical_treatment_id is not null and date_ended is null and animal_care = 1', :order => 'repeat_code'
	end
	
	def self.medical_user_tasks_today
		tday = Time.now.wday + 1
		find :all, :conditions => "((repeat_code = #{tday}) or (repeat_code = 0)) and medical_treatment_id is not null and date_ended is null and animal_care = 1", :order => 'repeat_code'
	end
	
	def self.medical_user_tasks_not_today
		tday = Time.now.wday + 1
		find :all, :conditions => "((repeat_code != #{tday}) and (repeat_code != 0)) and medical_treatment_id is not null and date_ended is null and animal_care = 1", :order => 'repeat_code'
	end

  def self.current
      self.find(:all, :conditions => "date_ended is null")
  end
  
  def self.expired
      self.find(:all, :conditions => "date_ended is not null")
  end

	def self.today
		tday = Time.now.wday + 1   
		find :all, :conditions => "(repeat_code = #{tday} or repeat_code = 0) and date_ended is null", :order => 'repeat_code, internal_description'
	end
	
	def general_task?
		if !self.cage_id and !self.medical_treatment_id then return true
		else return false
		end
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
    
  def find_post #gives a year day for which the task needs to be completed by
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
		
		task_census = TaskCensus.find(:first, :conditions => "task_id = #{self.id} and date = '#{Time.now.strftime("%Y-%m-%d")}'")
		task_census ? task_census.destroy : ''
  end
  
  def done
    self.done_with_date(Time.now)
  end
  
  def done_with_date(date_done)
    if (date_done.yday >= self.find_post) && (date_done.yday <= (self.find_post - self.jitter))
      if self.internal_description == 'change_pads' || self.internal_description == 'feed' || self.internal_description == 'change_cages' || self.internal_description == 'clean_floor' || self.internal_description == 'change_water'
				task_census = TaskCensus.find(:first, :conditions => "task_id = #{self.id} and date = '#{date_done.year}-#{date_done.month}-#{date_done.day}'")
				if task_census #if the populate_census_tasks rake didn't run
          task_census.date_done = date_done
          task_census.save
        end
			end
      
      task_history = TaskHistory.new
      task_history.task = self
      task_history.date_done = date_done
      task_history.user = @@current_user
      if self.internal_description == 'feed'
        task_history.fed = self.food
      end
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
  
  def doable
    if (Date.today.yday >= self.find_post) && (Date.today.yday <= (self.find_post - self.jitter))
      return true
    else
      return false
    end
  end
  
  def current?
    if self.date_ended == nil
      return true
    else
      return false
    end
  end
  
  def self.tasks_not_done_today(tasks)
		tasks_not_done = Array.new
    for task in tasks
			task.done_by_schedule ? '' : tasks_not_done << task
		end
		return tasks_not_done
  end
	
end