class TaskCensus < ActiveRecord::Base
	belongs_to :task
	belongs_to :room
	
	def self.populate_todays_tasks
		rooms = Room.find(:all)
		for room in rooms
			tday = Time.now.wday + 1
			todays_room_tasks = room.tasks.today
			
			for task in todays_room_tasks
				#find and if statements only needed if you run this code more than once per day (you can take out if run as a cron job - won't hurt to leave it in - just slower)
				task_census = TaskCensus.find(:first, :conditions => "task_id = #{task.id} and room_id = #{room.id} and date = '#{Date.today}'")
				if (task_census == nil)
					task_census = TaskCensus.new
					task_census.create_task_census(room, task)
				end
			end
		end
	end
	
	def create_task_census(room, task)
		self.room = room
		self.task = task
		self.date = Date.today
		self.internal_description = task.internal_description
		task.done_by_schedule ? self.date_done = task.last_done_date : ''
		self.save
	end
	
	def self.room_swap(room, task)
		task_census = TaskCensus.find(:first, :conditions => "task_id = #{task.id} and date = '#{Time.now.strftime("%Y-%m-%d")}'")
		task_census ? task_census.destroy : ''
		
		task_census = TaskCensus.new
		task_census.create_task_census(room, task)
	end
	
end