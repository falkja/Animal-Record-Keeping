class MedicalTreatment < ActiveRecord::Base
	belongs_to :medical_problem
	has_many :tasks
  has_many :bat_changes, :order => "date desc"
	
	def self.current
		find(:all, :conditions => 'date_closed is null')
	end
	
	def self.expired
		find(:all, :conditions => 'date_closed is not null', :order => "date_opened desc")
	end
	
	def done_today
		if self.tasks.length == 0
			return "no_task"
		else
			todays_treatment_task = Task.find(:first, :conditions => '(medical_treatment_id = ' + self.id.to_s + ') and (repeat_code = ' + (Time.now.wday + 1).to_s + ') and (date_ended is null)')
			if todays_treatment_task
				if (todays_treatment_task.done_by_schedule == false)
					return false
				else
					return true
				end
			else
				return "no_task"
			end
		end
	end
	
	def todays_task
		return Task.find(:first, :conditions => '(medical_treatment_id = ' + self.id.to_s + ') and (repeat_code = ' + (Time.now.wday + 1).to_s + ') and (date_ended is null)')
	end
  
  def end_treatment
    self.tasks.current.each{|task| task.deactivate}
    self.date_closed = Date.today
    self.save
  end
	
	def task_histories
		tasks = self.tasks
		task_histories = Array.new
		tasks.each{|task| task.task_histories.each{|task_history| task_histories << task_history}}
		task_histories = task_histories.sort_by{|task_history| [Time.now - task_history.date_done]}
		return task_histories
	end
  
  def self.populate_bat_changes
    all_treatments = self.find(:all)
    for treatment in all_treatments
      treatment_started = BatChange.new      
      treatment_started.date = treatment.date_opened
      treatment_started.bat = treatment.medical_problem.bat
      treatment_started.note = "STARTED: " + treatment.medical_problem.title
      treatment_started.medical_treatment = treatment
      #bat_change.user = no user logging in original design
      treatment_started.save
      
      if treatment.date_closed != nil
        treatment_ended = BatChange.new      
        treatment_ended.date = treatment.date_closed
        treatment_ended.bat = treatment.medical_problem.bat
        treatment_ended.note = "ENDED: " + treatment.medical_problem.title
        treatment_ended.medical_treatment = treatment
        #treatment_ended.user = no user logging in original design
        treatment_ended.save
      end
      
    end
  end
  
  def before_save
    
  end
  
  def after_save
    #create a bat change
  end
end