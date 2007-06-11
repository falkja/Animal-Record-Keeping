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
      msg_body = MyMailer.create_msg_for_tasks_undone(tasks_not_done)
      msg_body = msg_body + "Faithfully yours, etc."
      MyMailer.deliver_mail(user, "tasks not done today", greeting + msg_body)
      
    end
    
	end
  
  #all administrators get CCed on one email
  users_emails = Array.new
	User.administrator.each{|user| users_emails << user.email}
	
	tasks_not_done = Task.tasks_not_done_today(Task.today)
	if tasks_not_done.length > 0
		
		greeting = "Administrator(s),\n\n"
		msg_body = MyMailer.create_msg_for_tasks_undone(tasks_not_done)
		msg_body = msg_body + "Faithfully yours, etc."
		MyMailer.deliver_mass_mail(users_emails, "tasks not done today", greeting + msg_body)
		
	end
	
end