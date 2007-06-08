desc 'populate_census_entries'
task :populate_census_entries => :environment do
  TaskCensus.populate_todays_tasks
  print "task-census entries populated"
end

desc 'email_if_tasks_not_done'
task :email_if_tasks_not_done => :environment do
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
      msg_body = "This is a warning email to notify you that the following tasks were not completed today:\n"
      for task in tasks_not_done
        msg_body = msg_body + "Task: " + task.title + " Assigned to: " 
        if (task.users.length > 0)
          for user in task.users
            @msg_body = @msg_body + user.name + ", "
          end
        else
          msg_body = msg_body + "Animal Care Staff"
        end
        msg_body = msg_body + "\n"
      end
      msg_body = msg_body + "\nFaithfully yours, etc."
      MyMailer.deliver_mail(user, "tasks not done today", greeting + msg_body)
      
    end
    
	end
  
  #per administrator generated email
  tasks_not_done = Task.tasks_not_done_today(Task.today)
  for user in User.administrator
    greeting = "Administrator: " + user.name + ",\n\n"
    msg_body = "This is a warning email to notify you that the following tasks were not completed today:\n"
    for task in tasks_not_done
      msg_body = msg_body + "Task: " + task.title + " Assigned to: " + task.users ? task.users.each{|user| user.name : 'Animal Care Staff' + ", "} + "\n"
    end
    msg_body = msg_body + "\nFaithfully yours, etc."
    MyMailer.deliver_mail(user, "tasks not done today", greeting + msg_body)
  end
end