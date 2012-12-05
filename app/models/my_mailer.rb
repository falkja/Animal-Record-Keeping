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
	
	def self.create_msg_for_bats_not_weighed(bats)
		if bats.length > 0
			msg_body = "The following bats have not been weighed this past week (Mon. to Sun.):\n"
			for bat in bats
				msg_body = msg_body + "\nBat: " + bat.band
        msg_body = msg_body + "\nCage: " + bat.cage.name
				msg_body = msg_body + "\nOwner: " + bat.cage.user.name
        msg_body = msg_body + "\nLast weight: " + 
          bat.weights.recent.weight.to_s + "g on " + 
          bat.weights.recent.date.strftime("%a, %b %d, %Y") + "\n"
			end
			msg_body = msg_body + "\n*******************************************\n\n"
			return msg_body
		else
			return ''
		end
	end

  #gives one week to vaccinate, then sends emails listing each bat that
  #isn't vaccinated
  def self.create_msg_for_bats_not_vaccinated(bats)
    if bats.empty?
      return ''
    else
			msg_body = "The following bats have not been vaccinated\n" +
        "Note that is your only notification on this bat's vaccination status\n"
			for bat in bats
				msg_body = msg_body + "\nBat: " + bat.band
        if bat.cage
          msg_body = msg_body + "\nCage: " + bat.cage.name
          msg_body = msg_body + "\nOwner: " + bat.cage.user.name
        end
				msg_body = msg_body + "\nCollected: " +
          bat.collection_date.strftime("%b %d, %Y")
        msg_body = msg_body + "\nVaccination overdue by: " +
          (Date.today - bat.collection_date - 7).to_s + " days\n"
			end
			msg_body = msg_body + "\n*******************************************\n\n"
			return msg_body
		end
	end

  def self.create_msg_for_bats_not_flown(bats)
		if bats.length > 0
			msg_body = "The following bats have not been flown at least 3 times this past week (Mon. to Sun.):\n"
			for bat in bats
				msg_body = msg_body + "\nBat: " + bat.band
        msg_body = msg_body + "\nCage: " + bat.cage.name
				msg_body = msg_body + "\nOwner: " + bat.cage.user.name
				msg_body = msg_body + "\nLast 3 flight dates: \n"
        if bat.flights.length >= 3
          for flight in bat.flights[-3..-1].reverse
            msg_body = msg_body + "  " + flight.date.strftime("%a, %b %d, %Y") + "\n"
            if flight.exempt
              if flight.medical_problem
                msg_body = msg_body + "    Med. Problem: " + flight.medical_problem.title + "\n"
              end
              if flight.cage
                msg_body = msg_body + "    Flight Cage: " + flight.cage.name + "\n"
              end
              if flight.species
                msg_body = msg_body + "    Hibernating: " + flight.species.name + "\n"
              end
              if flight.has_surgery
                msg_body = msg_body + "    Surgery Exempt\n"
                if !flight.surgeries.empty?
                  for surgery in flight.surgeries
                    msg_body = msg_body + "      " + surgery.surgery_type.name + " at " +
                      nice_date_with_time(surgery.time) + " by " + surgery.user.name + "\n"
                  end
                end
              end
              if flight.quarantine
                msg_body = msg_body + "    In quarantine\n"
              end
            elsif flight.note && flight.note != ''
              msg_body = msg_body + "    Note: " + flight.note + "\n"
            end
          end
        end
			end
			msg_body = msg_body + "\n*******************************************\n\n"
			return msg_body
		else
			return ''
		end
	end


  def self.create_msg_for_protocol_changes(phs)
    if phs.length > 0
      msg_body = "The following protocol changes were made:\n"
      for ph in phs
        bat = ph.bat
        if ph.added == false
          rel_text = "Removed from protocol:"
        else
          rel_text = "Added to protocol:"
        end
        msg_body = msg_body + "\n#{rel_text}"
        msg_body = msg_body + "\n Bat: " + bat.band
        msg_body = msg_body + "\n  Number: " + ph.protocol.number
        msg_body = msg_body + "\n  Title: " + ph.protocol.title
        msg_body = msg_body + "\n  Bats (for " + bat.species.name +  ") currently on protocol: " + Bat.on_species(ph.protocol.bats,bat.species).length.to_s
        msg_body = msg_body + "\n  All bats (for " + bat.species.name +  ") ever on protocol: " + Bat.on_species(ph.protocol.all_past_bats,bat.species).length.to_s
        msg_body = msg_body + "\n  Bats allowed (for " + bat.species.name +  ") on protocol: " + ph.protocol.determine_allowed_bats(bat.species).to_s
        msg_body = msg_body + "\n  Action by: " + ph.user.name + "\n"
      end
      msg_body = msg_body + "\n*******************************************\n\n"
			return msg_body
    else
			return ''
		end
  end
	
  def self.create_msg_for_bats_added_removed(todays_changes)
    #use bat changes because if leave date was set for some other day rather than today, you would not find the bat
    if todays_changes.empty?
      return ''
    else
      todays_changes = todays_changes.sort_by{|ch| [ch.old_cage_id ? ch.old_cage_id : 0, ch.bat.band]}
      msg_body = "The following bats have been added or removed:\n"
      for ch in todays_changes
        if ch.old_cage_id
          rel_text = "Removed: "
          cage = Cage.find(ch.old_cage_id)
        end
        if ch.new_cage_id
          rel_text = "Added: "
          cage = Cage.find(ch.new_cage_id)
        end
        msg_body = msg_body + "\n#{rel_text}" + ch.bat.band
        msg_body = msg_body + "\n  Cage: " + cage.name
        msg_body = msg_body + "\n  Owner: " + cage.user.name
        msg_body = msg_body + "\n  Date: " + ch.date.strftime("%b %d, %Y")
        msg_body = msg_body + "\n  Action by: " + ch.user.name + "\n"
      end
      msg_body = msg_body + "\n*******************************************\n\n"
			return msg_body
		end
  end
  
  def self.create_msg_for_bats_not_on_protocol(bats)
    if bats.empty?
      return ''
    else
			msg_body = "The following bats do not have protocols:\n"
			for bat in bats
				msg_body = msg_body + "\nBat: " + bat.band
        if bat.cage
          msg_body = msg_body + "\nCage: " + bat.cage.name
          msg_body = msg_body + "\nOwner: " + bat.cage.user.name + "\n"
        end
			end
			msg_body = msg_body + "\n*******************************************\n\n"
			return msg_body
		end
  end
     
	def self.create_msg_for_tasks_not_done(tasks_not_done)
		if tasks_not_done.length > 0
      msg_body = "The following tasks were not completed:\n\n"
      for task in tasks_not_done
        msg_body = msg_body + "Task: " + task.title
				if task.room
					msg_body = msg_body + "\nRoom: " + task.room.name
				end
        if task.cage
          msg_body = msg_body + "\nCage owner: " + task.cage.user.name
        end
				if task.medical_treatment
					msg_body = msg_body + "\nBat: " + 
            task.medical_treatment.medical_problem.bat.band
					msg_body = msg_body + "\nMedical Problem: " + 
            task.medical_treatment.medical_problem.title
					msg_body = msg_body + "\nMedical Problem Description: " + 
            task.medical_treatment.medical_problem.description
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
  
  def self.create_reminder_msg_for_bats_not_weighed(bats)
    if bats.empty?
      return ''
    else
      msg_body = "This is a weekly reminder that the following bats still need to be weighed this week (Mon. starts the week)." +
      "\nYou have " + (7-Date.today.wday).to_s + " days left in the week (weekly checks are done on Sunday night).\n"
			for bat in bats
				msg_body = msg_body + "\nBat: " + bat.band
        if bat.cage
          msg_body = msg_body + "\nCage: " + bat.cage.name
          msg_body = msg_body + "\nOwner: " + bat.cage.user.name
        end
        msg_body = msg_body + "\nLast weight: " + 
          bat.weights.recent.weight.to_s + "g on " + 
          bat.weights.recent.date.strftime("%a, %b %d, %Y") + "\n"
			end
      
			msg_body = msg_body + "\n*******************************************\n\n"
			return msg_body
    end
  end
  
  def self.create_reminder_msg_for_bats_not_flown(bats)
    if bats.empty?
      return ''
    else
      msg_body = "This is a reminder that the following bats still need flights this week (Mon. starts the week)."+
        "\nChecks of flights will be done in " + (7-Date.today.wday).to_s + " days (Sun. night)." +
        "\n3 flights per bat per week are needed." +
        "\nBatkeeping believes that you should have at least " + (Date.today.wday-1).to_s + " flights recorded so far this week." +
        "\nThis is your final and only reminder for flights this week.\n"
			for bat in bats
				msg_body = msg_body + "\nBat: " + bat.band
        if bat.cage
          msg_body = msg_body + "\nCage: " + bat.cage.name
          msg_body = msg_body + "\nOwner: " + bat.cage.user.name
        end
        msg_body = msg_body + "\nLast flown: " + 
          bat.flights[-1].date.strftime("%a, %b %d, %Y")
        flights_this_week = bat.flights_this_week(Date.today).length
        msg_body = msg_body + "\n" + flights_this_week.to_s + " " +
          (flights_this_week > 1 ? "flight".pluralize : "flight") + " recorded this week." + "\n"
			end
      msg_body = msg_body + "\n*******************************************\n\n"
			return msg_body
    end
  end
  
  def self.bats_which_need_reminders(user, date)
    bats_not_weighed_reminders = []
    bats_not_flown_reminders = []
    if user.wants_reminder_emails_weights && date.wday == 4
      bats_not_weighed_reminders = Bat.not_weighed(user.bats,date)
    end
    if date.wday == 0 #Sunday is day-of-week 0; Saturday is day-of-week 6
      user.sent_reminder_email(false)
    elsif user.wants_reminder_emails_flights && !user.got_reminder_email_flights
      case date.wday
      when 2 #Tue
        bats_not_flown_reminders = Bat.not_flown(user.bats,1)
      when 3 #Wed
        bats_not_flown_reminders = Bat.not_flown(user.bats,2)
      when 4 #Thur
        bats_not_flown_reminders = Bat.not_flown(user.bats,3)
      else
        bats_not_flown_reminders = []
      end
    end
    return bats_not_weighed_reminders, bats_not_flown_reminders
  end
  
  def self.needs_email(tasks,not_weighed,not_flown,protocol_changes,bat_changes,not_on_protocols,not_weighed_reminder,not_flown_reminder,not_vaccinated,off_quarantine)
    return !tasks.empty? || !not_weighed.empty? ||
      !not_flown.empty? || !protocol_changes.empty? ||
      !bat_changes.empty? || !not_on_protocols.empty? ||
      !not_weighed_reminder.empty? || !not_flown_reminder.empty? ||
      !not_vaccinated.empty? || !off_quarantine.empty?
  end
	
	def self.email_users
    salutation = "Faithfully yours, etc."
    today = Date.today
    msg_body_total = ""
    user_total = []
	  for user in User.current - User.administrator #per user generated email minus admins
      users_tasks_not_done = Task.tasks_not_done_today(user.all_tasks)
      users_protocol_changes = ProtocolHistory.users_todays_histories(user)
      users_bat_changes = BatChange.users_bats_deactivated_today(user)
      users_bats_not_on_protocols = Bat.not_on_protocol(user.bats)
      users_bats_not_vaccinated = Bat.not_vaccinated_needs_email(user.bats)
      users_bats_off_quarantine = Bat.off_quarantine(user.bats)
      
      users_bats_not_weighed = []
      users_bats_not_flown = []
      if today.wday == 0 #Sunday is day-of-week 0; Saturday is day-of-week 6
        users_bats_not_weighed = Bat.not_weighed(user.bats,today)
        users_bats_not_flown = Bat.not_flown(user.bats,3)
      end
      users_bats_not_weighed_reminders, users_bats_not_flown_reminders = 
        self.bats_which_need_reminders(user, today)
      
      if self.needs_email(users_tasks_not_done,users_bats_not_weighed,
          users_bats_not_flown,users_protocol_changes,users_bat_changes,
          users_bats_not_on_protocols,users_bats_not_weighed_reminders,
          users_bats_not_flown_reminders,users_bats_not_vaccinated,
          users_bats_off_quarantine)
        greeting = "Hi " + user.name + ",\n\n"
        greeting = greeting + Time.now.strftime('%A, %B %d, %Y') + "\n\n"
        msg_body = self.create_msg_body(users_tasks_not_done,
          users_bats_not_weighed,users_bats_not_flown,users_protocol_changes,
          users_bat_changes,users_bats_not_vaccinated,users_bats_not_on_protocols,
          users_bats_not_weighed_reminders,users_bats_not_flown_reminders,
          users_bats_off_quarantine)
        self.deliver_mail(user.email, "batkeeping email: notifications and reminders", greeting + msg_body + salutation)
        if !users_bats_not_flown_reminders.empty?
          user.sent_reminder_email(true)
        end
        msg_body_total = msg_body_total + "Sent to: " +user.name + "\n\n" + msg_body+ "\n\n"
        user_total << user
      end
    end
    
    #copy to make sure it's working
    if !user_total.empty?
      greeting = "Ben" + ",\n"
      greeting = greeting + Time.now.strftime('%A, %B %d, %Y') + "\n\n"
      self.deliver_mail('falk.ben@gmail.com', 
        "batkeeping copy of email sent to: " + user_total.collect{|u| u.name}.to_sentence,
        greeting + msg_body_total + salutation)
    end
    
    for user_admin in User.administrator #reminder emails for admins
      bats_not_weighed_reminders, bats_not_flown_reminders = self.bats_which_need_reminders(user_admin, today)
      if !bats_not_weighed_reminders.empty? || !bats_not_flown_reminders.empty?
        greeting = "Hi " + user_admin.name + ",\n\n"
        greeting = greeting + Time.now.strftime('%A, %B %d, %Y') + "\n\n"
        msg_body = MyMailer.create_reminder_msg_for_bats_not_weighed(bats_not_weighed_reminders)
        msg_body = msg_body + MyMailer.create_reminder_msg_for_bats_not_flown(bats_not_flown_reminders)
        MyMailer.deliver_mail(user_admin.email, "batkeeping email: personal reminders", greeting + msg_body + salutation)
        if !bats_not_flown_reminders.empty?
          user_admin.sent_reminder_email(true)
        end
      end
    end
		
		#all administrators get CCed on one email and see all notifications
		admin_emails = User.administrator.collect{|admin| admin.email}
		
		tasks_not_done = Task.tasks_not_done_today(Task.today)
    protocol_changes = ProtocolHistory.todays_histories
    todays_bat_changes = BatChange.deactivated_today
    bats_not_on_protocols = Bat.not_on_protocol(Bat.active)
    bats_not_vaccinated = Bat.not_vaccinated_needs_email(Bat.active)
    bats_off_quarantine = Bat.off_quarantine(Bat.active)

    bats_not_weighed = []
    bats_not_flown = []
    if today.wday == 0 #Sunday is day-of-week 0; Saturday is day-of-week 6
      bats_not_weighed = Bat.not_weighed(Bat.active,today)
      bats_not_flown = Bat.not_flown(Bat.active,3)
    end

		if self.needs_email(tasks_not_done,bats_not_weighed,
          bats_not_flown,protocol_changes,todays_bat_changes,
          bats_not_on_protocols,[],[],bats_not_vaccinated,
          bats_off_quarantine)
			greeting = "Administrator(s),\n\n"
      greeting = greeting + Time.now.strftime('%A, %B %d, %Y') + "\n\n"
      msg_body = MyMailer.create_msg_body(tasks_not_done,bats_not_weighed,
        bats_not_flown,protocol_changes,todays_bat_changes,bats_not_vaccinated,
        bats_not_on_protocols,[],[],bats_off_quarantine)
			MyMailer.deliver_mass_mail(admin_emails, "batkeeping email: notifications", greeting + msg_body + salutation)
      bats_not_vaccinated.empty? ? '' : Bat.update_all("vaccination_email_sent = true", ['id IN (?)',bats_not_vaccinated])
		end
	end

  def self.create_msg_body(tasks_not_done,bats_not_weighed,bats_not_flown,protocol_changes,bat_changes,not_vaccinated,not_on_protocols,bats_not_weighed_reminders,bats_not_flown_reminders,off_quarantine)
    msg_body = MyMailer.create_msg_for_tasks_not_done(tasks_not_done)
    msg_body = msg_body + MyMailer.create_msg_for_bats_not_weighed(bats_not_weighed)
    msg_body = msg_body + MyMailer.create_msg_for_bats_not_flown(bats_not_flown)
    
    msg_body = msg_body + MyMailer.create_reminder_msg_for_bats_not_weighed(bats_not_weighed_reminders)
    msg_body = msg_body + MyMailer.create_reminder_msg_for_bats_not_flown(bats_not_flown_reminders)
    
    msg_body = msg_body + MyMailer.create_msg_for_bats_added_removed(bat_changes)
    msg_body = msg_body + MyMailer.create_msg_for_protocol_changes(protocol_changes)
    msg_body = msg_body + MyMailer.create_msg_for_bats_not_vaccinated(not_vaccinated)
    msg_body = msg_body + MyMailer.create_msg_for_bats_not_on_protocol(not_on_protocols)
    msg_body = msg_body + MyMailer.off_quarantine_msg(off_quarantine)
    return msg_body
  end
  
  def self.email_after_bats_moved(bats,old_cage,new_cage)
		msg_body = "This is a confirmation email to notify you that the following bat(s): " + bats.collect{|b| b.band}.to_sentence
		if old_cage && new_cage
			msg_body = msg_body + " were moved from " + old_cage.name + " to " + new_cage.name
      subject = "Moved bat(s)"
      greeting = "Hi " + [old_cage.user.name, new_cage.user.name].uniq.to_sentence + ",\n\n"
      email = [old_cage.user.email, new_cage.user.email].uniq
		elsif new_cage
			msg_body = msg_body + " were moved into " + new_cage.name
      subject = "You have new (or reactivated) bat(s)"
      greeting = "Hi " + new_cage.user.name + ",\n\n"
      email = new_cage.user.email
		else
			msg_body = msg_body + " were deactivated and moved out of " + old_cage.name
      subject = "Bat(s) deactivated"
      greeting = "Hi " + old_cage.user.name + ",\n\n"
      email = old_cage.user.email
		end
		msg_body = msg_body + "\n\nFaithfully yours, etc."		
		
    if !email.kind_of?(Array)
      MyMailer.deliver_mail(email, subject, greeting + msg_body)
    else
      MyMailer.deliver_mass_mail(email, subject, greeting + msg_body)
    end
  end
  
  def self.email_at_protocol_warning_limit(protocol,bat,user,allowed_bat)
    msg_body = "This is a warning email to notify you that the following protocol is at its warning limit: "
    msg_body = msg_body + MyMailer.protocol_msg(protocol,bat,allowed_bat,user)

    users = (protocol.users | (User.administrator - User.not_researcher))
    
    greeting = "Hi " + users.collect{|u| u.name}.to_sentence + ",\n\n"
    salutation = "Faithfully yours, etc."
    
    MyMailer.deliver_mass_mail(users.collect{|u| u.email}, 
      "batkeeping email: warning limit reached on protocol!", greeting + msg_body + salutation)
  end

  def self.email_at_protocol_limit(protocol,bat,user,allowed_bat)
    msg_body = "The following protocol is at its allowed bats limit for species #{bat.species.name}.\n\n"
    msg_body = msg_body + "In order to be able to add more bats to this protocol, you will need to modify the protocol and change the allowed bats number for this species.\n\n"
    msg_body = msg_body + MyMailer.protocol_msg(protocol,bat,allowed_bat,user)

    users = (protocol.users | (User.administrator - User.not_researcher))

    greeting = "Hi " + users.collect{|u| u.name}.to_sentence + ",\n\n"
    salutation = "Faithfully yours, etc."

    MyMailer.deliver_mass_mail(users.collect{|u| u.email},
      "batkeeping email: absolute limit reached on protocol!", greeting + msg_body + salutation)
  end

  def self.protocol_msg(protocol,bat,allowed_bat,user)
    msg_body = "\n  Number: " + protocol.number
    msg_body = msg_body + "\n  Title: " + protocol.title
    # we have to add one to the current bats because the bat hasn't actually been added to the protocol yet
    msg_body = msg_body + "\n  Current bats (for " + bat.species.name + "): " + (Bat.on_species(protocol.bats,bat.species).length + 1).to_s
    msg_body = msg_body + "\n  All bats (for " + bat.species.name + ") ever: " + Bat.on_species(protocol.all_past_bats,bat.species).length.to_s
    msg_body = msg_body + "\n  Bats allowed (for " + bat.species.name + "): " + allowed_bat.number.to_s
    msg_body = msg_body + "\n  Warning limit (for " + bat.species.name + "): " + allowed_bat.warning_limit.to_s
    msg_body = msg_body + "\n  Action by: " + user.name + "\n\n"
  end

  def self.off_quarantine_msg(bats)
    if bats.length > 0
			msg_body = "The following bats are off quarantine beginning tomorrow, " +
        (Date.today + 1.day).strftime("%m/%d/%Y") + ":\n"
			for bat in bats
				msg_body = msg_body + "\nBat: " + bat.band
        msg_body = msg_body + "\nCage: " + bat.cage.name
				msg_body = msg_body + "\nOwner: " + bat.cage.user.name
        msg_body = msg_body + "\nVaccinated on: " + bat.vaccination_date.strftime("%a, %b %d, %Y") + "\n"
			end
			msg_body = msg_body + "\n*******************************************\n\n"
			return msg_body
		else
			return ''
		end
  end
end