desc 'populate_census_entries'
task :populate_census_entries => :environment do
  TaskCensus.populate_todays_tasks
  print "task-census entries populated"
end

desc 'email_if_tasks_not_done'
task :email_if_tasks_not_done => :environment do
	for user in User.current
		tasks = user.tasks.tasks_not_done_today
		tasks.each{|task| print(task.title + " " + user.name + "\n")}
	end
end