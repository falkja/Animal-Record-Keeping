#order in which they are done:

#1 (populate_daily_flight_logs)
task :populate_daily_flight_logs => :environment do
  Flight.populate_daily_flight_logs
end

#2 (daily_task_check)
desc 'email_if_tasks_not_done'
task :email_if_tasks_not_done => :environment do
	MyMailer.email_users
end

#3 (batkeeping_daily_tasks) - done at start of day
desc 'populate_census_entries'
task :populate_census_entries => :environment do
  TaskCensus.populate_todays_tasks
end


###########################################
#one time use tasks:
###########################################

task :test_email => :environment do
  MyMailer.deliver_mail("bfalk@umd.edu", "test_email", "let ben know if you get this")
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

#one time use task
#fixes database for quarantine bats that weren't having their history of
#quarantine stored in database for flight logs
desc 'quarantine_bats_flight_logs'
task :quarantine_bats_flight_logs => :environment do
  bats = Bat.active
  for b in bats
    if b.quarantine?
      for f in b.flights
        f.quarantine = true;
        f.save
      end
    end
  end
end

#one time use for populating allowed bat entries for existing protocols
desc 'add_allowed_bats_to_existing_protocols'
task :add_allowed_bats_to_existing_protocols => :environment do
  for p in Protocol.all
    for sp in Species.all
      ab = AllowedBat.new(:species => sp, :number => 0, :protocol => p)
      ab.save
    end
  end
end

task :ChangeDateAddedRemovedToSingleDateProtocolHistories => :environment do
  for p in ProtocolHistory.all
    if p.date_added
      p.added = true
      p.date = p.date_added
    else
      p.added = false
      p.date = p.date_removed
    end
    p.save
  end
end

task :ChangeDateAddedRemovedToMultDateProtocolHistories => :environment do
  for p in ProtocolHistory.all
    if p.added
      p.date_added = p.date
    else
      p.date_removed = p.date
    end
    p.save
  end
end
