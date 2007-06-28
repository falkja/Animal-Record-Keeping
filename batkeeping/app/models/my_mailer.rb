class MyMailer < ActionMailer::Base

  def mail(recipient, msg_subject, msg_body)
    from "batkeeping@zoopsych2-63.umd.edu"
    recipients recipient
    subject msg_subject
    body :email_body => msg_body
  end
  
  def mass_mail(recipients, msg_subject, msg_body)
    from "batkeeping@zoopsych2-63.umd.edu"
    recipients recipients
    subject msg_subject
    body :email_body => msg_body
  end
	
	def self.create_msg_for_tasks_not_done(tasks_not_done)
		if tasks_not_done.length > 0
      msg_body = "This is a warning email to notify you that the following tasks were not completed today (" + Time.now.strftime('%A, %B %d, %Y') + "):\n\n*******************************************\n\n"
      for task in tasks_not_done
        msg_body = msg_body + "Task: " + task.title
				if task.room
					msg_body = msg_body + "\nRoom: " + task.room.name
				end
				msg_body = msg_body + "\nAssigned to: " 
        if (task.users.length > 0)
          for user in task.users
            msg_body = msg_body + user.name
						if user != task.users.last
							msg_body = msg_body + ", "
						end
          end
        else
          msg_body = msg_body + "Animal Care Staff"
        end
        msg_body = msg_body + "\n\n"
      end
    else
      msg_body = "All of today's tasks completed.\n\n"
    end
		msg_body = msg_body + "*******************************************\n\n"
		return msg_body
	end
	
	def self.email_users
	  for user in User.current
			users_tasks = user.tasks.today
			
			if ((user.animal_care_user? && ( (Time.now.wday == 1) || (Time.now.wday == 2) || (Time.now.wday == 3) || (Time.now.wday == 4) || (Time.now.wday == 5))) || (user.weekend_care_user? && (Time.now.wday == 6 || Time.now.wday == 0)))
				Task.animal_care_user_general_tasks_today.each{|task| users_tasks << task}
				Task.animal_care_user_weighing_tasks_today.each{|task| users_tasks << task}
				Task.animal_care_user_feeding_tasks_today.each{|task| users_tasks << task}
			end
			
			if user.medical_care_user?
				Task.medical_user_tasks_today.each{|task| users_tasks << task}
			end
			
			tasks_not_done = Task.tasks_not_done_today(users_tasks)
			
			if tasks_not_done.length > 0
				
				#per user generated email
				greeting = "Hi " + user.name + ",\n\n"
				msg_body = MyMailer.create_msg_for_tasks_not_done(tasks_not_done)
				msg_body = msg_body + "Faithfully yours, etc."
				MyMailer.deliver_mail(user.email, "tasks not done today", greeting + msg_body)
				
			end
			
		end
		
		#all administrators get CCed on one email
		users_emails = Array.new
		User.administrator.each{|user| users_emails << user.email}
		
		tasks_not_done = Task.tasks_not_done_today(Task.today)
		if tasks_not_done.length > 0
			
			greeting = "Administrator(s),\n\n"
			msg_body = MyMailer.create_msg_for_tasks_not_done(tasks_not_done)
			msg_body = msg_body + "Faithfully yours, etc."
			MyMailer.deliver_mass_mail(users_emails, "tasks not done today", greeting + msg_body)
			
		end
	end
end