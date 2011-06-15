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
			msg_body = "The following bats have not been weighed in at least 1 week:\n"
			for bat in bats
				msg_body = msg_body + "\nBat: " + bat.band
        msg_body = msg_body + "\nCage: " + bat.cage.name
				msg_body = msg_body + "\nOwner: " + bat.cage.user.name
				msg_body = msg_body + "\nLast weigh date: " + 
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
  def self.create_msg_for_bats_not_vaccinated(b_not_vacc)
    if b_not_vacc.empty?
      return ''
    else
			msg_body = "The following bats have not been vaccinated:\n"
			for bat in b_not_vacc
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
			msg_body = "The following bats have not been flown at least 3 times in the last week:\n"
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
            elsif flight.note
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
    todays_changes.sort_by{|ch| ch.bat.band}
    if todays_changes.empty?
      return ''
    else
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
        msg_body = msg_body + "\n  Date Actually Removed: " + ch.date.strftime("%b %d, %Y")
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
      msg_body = "This is a warning email to notify you that the following tasks were not completed:\n\n"
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
	
	def self.email_users
    salutation = "Faithfully yours, etc."
	  for user in User.current - User.administrator
      #per user generated email minus admins
      users_tasks_not_done = Task.tasks_not_done_today(user.all_tasks)
      users_bats_not_weighed = Bat.not_weighed(user.bats,Time.now)
      users_bats_not_flown = Bat.not_flown(user.bats)
      users_protocol_changes = ProtocolHistory.users_todays_histories(user)
      users_bat_changes = BatChange.users_bats_deactivated_today(user)
      users_bats_not_vaccinated = Bat.not_vaccinated(user.bats)
      users_bats_not_on_protocols = Bat.not_on_protocol(user.bats)
        
      if users_tasks_not_done.length > 0 || users_bats_not_weighed.length > 0 ||
          users_bats_not_flown.length > 0 || users_protocol_changes.length > 0 ||
          users_bat_changes.length > 0 || users_bats_not_vaccinated.length > 0
        greeting = "Hi " + user.name + ",\n\n"
        greeting = greeting + Time.now.strftime('%A, %B %d, %Y') + "\n\n"
        msg_body = MyMailer.create_msg_body(users_tasks_not_done,
          users_bats_not_weighed,users_bats_not_flown,users_protocol_changes,
          users_bat_changes,users_bats_not_vaccinated,users_bats_not_on_protocols)
        MyMailer.deliver_mail(user.email, "batkeeping email: daily notificiations", greeting + msg_body + salutation)
      end
    end
		
		#all administrators get CCed on one email and see everything
		admin_emails = User.administrator.collect{|admin| admin.email}
		
		tasks_not_done = Task.tasks_not_done_today(Task.today)
    bats_not_weighed = Bat.not_weighed(Bat.active,Time.now)
    protocol_changes = ProtocolHistory.todays_histories
    bats_not_flown = Bat.not_flown(Bat.active)
    todays_bat_changes = BatChange.deactivated_today
    bats_not_vaccinated = Bat.not_vaccinated(Bat.active)
    bats_not_on_protocols = Bat.not_on_protocol(Bat.active)
    
		if tasks_not_done.length > 0 || bats_not_weighed.length > 0 || 
        bats_not_flown.length > 0 || protocol_changes.length > 0 ||
        todays_bat_changes.length > 0 || bats_not_vaccinated.length > 0
			greeting = "Administrator(s),\n\n"
      greeting = greeting + Time.now.strftime('%A, %B %d, %Y') + "\n\n"
      msg_body = MyMailer.create_msg_body(tasks_not_done,bats_not_weighed,
        bats_not_flown,protocol_changes,todays_bat_changes,bats_not_vaccinated,
        bats_not_on_protocols)
			MyMailer.deliver_mass_mail(admin_emails, "batkeeping email: daily notificiations", greeting + msg_body + salutation)
		end
	end

  def self.create_msg_body(tasks_not_done,bats_not_weighed,bats_not_flown,protocol_changes,bat_changes,not_vaccinated,not_on_protocols)
    msg_body = MyMailer.create_msg_for_tasks_not_done(tasks_not_done)
    msg_body = msg_body + MyMailer.create_msg_for_bats_not_weighed(bats_not_weighed)
    msg_body = msg_body + MyMailer.create_msg_for_bats_not_flown(bats_not_flown)
    msg_body = msg_body + MyMailer.create_msg_for_protocol_changes(protocol_changes)
    msg_body = msg_body + MyMailer.create_msg_for_bats_added_removed(bat_changes)
    msg_body = msg_body + MyMailer.create_msg_for_bats_not_vaccinated(not_vaccinated)
    msg_body = msg_body + MyMailer.create_msg_for_bats_not_on_protocol(not_on_protocols)
    return msg_body
  end
  
  def self.email_after_bats_moved(bats,old_cage,new_cage)
		msg_body = "This is a confirmation email to notify you that the following bat(s): " + bats.collect{|b| b.band}.to_sentence
		if old_cage && new_cage
			msg_body = msg_body + " were moved from " + old_cage.name + " to " + new_cage.name
		elsif new_cage
			msg_body = msg_body + "were moved into " + new_cage.name
		else
			msg_body = msg_body + "were deactivated and moved out of " + old_cage.name
		end
		msg_body = msg_body + "\n\nFaithfully yours, etc."		
		
    if new_cage
      greeting = "Hi " + new_cage.user.name + ",\n\n"
      MyMailer.deliver_mail(new_cage.user.email, "moved bats", greeting + msg_body)
    end
    if (old_cage && !new_cage) || (old_cage && new_cage && (new_cage.user != old_cage.user))
			greeting = "Hi " + old_cage.user.name + ",\n\n"
			MyMailer.deliver_mail(old_cage.user.email, "moved bats", greeting + msg_body)
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
end