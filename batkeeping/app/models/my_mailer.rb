class MyMailer < ActionMailer::Base

  def mail(recipient, msg_subject, msg_body)
    from "batkeeping@pushkin.umd.edu"
    recipients recipient
    subject msg_subject
    body :email_body => msg_body
  end
  
  def mass_mail(recipients, msg_subject, msg_body)
    from "batkeeping@pushkin.umd.edu"
    recipients recipients
    subject msg_subject
    body :email_body => msg_body
  end
	
	def self.create_msg_for_tasks_not_done(tasks_not_done)
		if tasks_not_done.length > 0
      msg_body = "This is a warning email to notify you that the following tasks were not completed today (" + Time.now.strftime('%B %d, %Y') + "):\n\n*******************************************\n\n"
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
end