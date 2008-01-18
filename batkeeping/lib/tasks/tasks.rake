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

task :nil_out_cohs => :environment do
  bats = Bat.not_active
  for bat in bats
    coh = CageOutHistory.find(:first, :conditions => "bat_id = #{bat.id}", :order => "date desc")
    if coh #because bats with no move history don't have coh's
      coh.cage_in_history = nil
      coh.save
    end
  end
end

task :populate_bat_changes => :environment do
  Bat.populate_bat_changes
end