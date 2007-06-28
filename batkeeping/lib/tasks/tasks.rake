desc 'populate_census_entries'
task :populate_census_entries => :environment do
  TaskCensus.populate_todays_tasks
end

task :test_email => :environment do
  MyMailer.deliver_mail("bfalk@umd.edu", "test_email", "let ben know if you get this")
end

desc 'email_if_tasks_not_done'
task :email_if_tasks_not_done => :environment do
	MyMailer.email_users
end