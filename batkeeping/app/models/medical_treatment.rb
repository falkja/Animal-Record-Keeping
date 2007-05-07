class MedicalTreatment < ActiveRecord::Base
	belongs_to :medical_problem
	has_many :tasks
	
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
	
	def task_exists_on_day(day)
		if Task.find(:first, :conditions => '(medical_treatment_id = ' + self.id.to_s + ') and (repeat_code = ' + day.to_s + ') and (date_ended is null)')
			return true
		else
			return false
		end
	end
	
	def todays_task
		return Task.find(:first, :conditions => '(medical_treatment_id = ' + self.id.to_s + ') and (repeat_code = ' + (Time.now.wday + 1).to_s + ') and (date_ended is null)')
	end
end