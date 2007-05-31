class TaskCensus < ActiveRecord::Base
	belongs_to :task
	belongs_to :room
	
	def self.populate_todays_tasks
		rooms = Room.find(:all)
		for room in rooms
			tday = Time.now.wday + 1
			todays_room_tasks = Task.find(:all, :conditions => "(internal_description = 'change_water' or internal_description = 'change_cages' or internal_description = 'change_pads' or internal_description = 'clean_floor') and (repeat_code = 0 or repeat_code = #{tday}) and date_ended is null")
			
			room.cages.each{|cage| cage.tasks.feeding_tasks_today.each{|task| todays_room_tasks << task}} #adds the room's feeding tasks to the list
			
			for task in todays_room_tasks
				#find and if statements only needed if you run this code more than once per day (you can take out if run as a cron job - won't hurt to leave it in - just slower)
				task_census = TaskCensus.find(:first, :conditions => "task_id = #{task.id} and room_id = #{room.id} and date = '#{Date.today}'")
				if (task_census == nil)
					task_census = TaskCensus.new
					task_census.room = room
					task_census.task = task
					task_census.date = Date.today
					task_census.internal_description = task.internal_description
					task.done_by_schedule ? task_census.date_done = task.last_done_date : ''
					task_census.save
				end
			end
			
		end
	end
end