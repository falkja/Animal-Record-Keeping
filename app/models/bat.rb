class Bat < ActiveRecord::Base
	belongs_to :cage
	belongs_to :species
  has_one :user, :through => :cage
  has_one :room, :through => :cage
	has_many :weights, :order => "date desc"
	has_many :cage_in_histories, :order => "date desc"
	has_many :cage_out_histories, :order => "date desc"
	has_many :medical_problems, :order => "date_opened desc"
	has_many :bat_notes, :order => "date desc"
	has_many :bat_changes, :order => "date desc"
	has_and_belongs_to_many :protocols, :order => "number, title"
	has_many :flights, :order => "date asc"
	has_many :protocol_histories, :order => "date desc"
  has_many :surgeries, :order => "time desc"
	
	validates_presence_of :band, :collection_place
	validates_uniqueness_of :band
	
	@@current_user = nil #needed for the sig
	@@comment = nil #needed if we wanna comment a cage move
	
	
	#returns an empty string for the cage.name instead of a nil for sorting
	def cage_never_nil
		batcage = self.cage
		if batcage != nil
			return batcage
		else
			batcage = Cage.new
			batcage.name = ''
			return batcage
		end
	end
	
	def average_weight
		if self.weights.length > 0
			Weight.average(:weight, :conditions => "bat_id = #{self.id}")
		else
			return 0.0
		end
	end
	
	#From http://www.therailsway.com/tags/rails
	#This lets us do Bat.active AS WELL AS cage.bats.active !
	def self.active
		find :all, :conditions => 'leave_date is null', :order => 'band'
	end
		
	def self.not_active
		find :all, :conditions => 'leave_date is not null', :order => 'band'
	end
	
	#returns all the sick bats
	def self.sick
		@medical_problems = MedicalProblem.current
		bat_ids = Array.new
		for medical_problem in @medical_problems
			bat_ids << medical_problem.bat.id
		end
		Bat.find(bat_ids.uniq, :order => 'band')
	end
  
  def self.sick_or_previously_sick
    @medical_problems = MedicalProblem.find(:all)
		bat_ids = Array.new
		for medical_problem in @medical_problems
			bat_ids << medical_problem.bat.id
		end
		Bat.find(bat_ids.uniq, :order => 'band')
  end
	
	def self.not_weighed(bats)
		bats_not_weighed = Array.new
		bats.each{|bat| ( bat.weights.recent && (bat.weights.recent.date < 
            (Time.now - 7.days)) && bat.monitor_weight) ? 
            bats_not_weighed << bat : ''}
		return bats_not_weighed
	end
	
	def Bat.set_user_and_comment(user, cmt)
		@@current_user = user
		@@comment = cmt
	end
	
	#What was the date that the first bat was added to the colony (acc to database)
	def self.earliest_addition
		bat = Bat.find :first, :order => 'collection_date asc'
		bat ? yoda = bat.collection_date : yoda = nil 
		return yoda
	end
  
  def time_in_lab
    if self.leave_date
      (leave_date - self.collection_date).to_i
    else
      (Date.today - self.collection_date).to_i
    end
  end
	
	#call this whenever you think the bat's cage could have changed
	#it updates both the cage out and cage in histories as required
	def log_cage_change(old_cage, new_cage)
		
    unless new_cage == nil #if it is nill then the bat died or was exported and wasn't moved to a new cage
			#Make a new entry in the cage in histories
			cih = CageInHistory.new
			cih.bat = self
			cih.cage = new_cage
			cih.user = @@current_user
			cih.note = @@comment
			cih.date = Time.new
			cih.save
		end   
    
		#We may have to close out the last cage_in_history
		#by creating a cage_out_history and attaching it to the cage_in_history
    unless old_cage == nil #this means we just created it
			cihs = self.cage_in_histories #a list of histories sorted by latest date
			if cihs.length > 0
				cih = cihs[0]
			end
			
			coh = CageOutHistory.new
			coh.bat = self
			coh.cage = old_cage
			coh.user = @@current_user
			coh.note = @@comment
			coh.date = Time.new
			new_cage ? coh.cage_in_history = cih : ''
			coh.save
		end
	end
	
	def log_bat_change(old_cage, new_cage)
		if new_cage == nil
			cage_history = self.cage_out_histories[0]
		else
			cih = self.cage_in_histories[0]
			cage_history = cih
		end
		
		bat_change = BatChange.new
		bat_change.date = cage_history.date
		bat_change.bat = self
		old_cage ? bat_change.old_cage_id = old_cage.id : ''
		new_cage ? bat_change.new_cage_id = new_cage.id : ''
		bat_change.note = cage_history.note
		bat_change.user = cage_history.user
		if old_cage && new_cage #a true cage change
			if old_cage.user != new_cage.user # with an owner change
				bat_change.owner_new_id = new_cage.user.id
				bat_change.owner_old_id = old_cage.user.id
			end
		elsif old_cage # deactivated
			bat_change.owner_old_id = old_cage.user.id
			bat_change.date = bat_change.bat.leave_date
		elsif new_cage # new bat
			bat_change.owner_new_id = new_cage.user.id
		end
		bat_change.cage_in_history = cih
		bat_change.save
	end
	
	#called just before creation
	def before_create
		@old_cage = nil
	end
	
	#before_save is called automatically just before a class is saved to the db
	# Tasks
	# 1. Save the original cage so we can use it to update cage change histories
	def before_save
		self.id ? @old_cage = Bat.find(self.id).cage : ''
	end
		
	def after_save
		@new_cage = self.cage
		unless @old_cage == @new_cage
			log_cage_change(@old_cage, @new_cage)
			log_bat_change(@old_cage, @new_cage)
		end
	end
  
  #returns the weight of the bat on or before date
  def weight_on(date)
    Weight.find(:first, :conditions => 
        ["bat_id = ? and date <= ?",self.id,date], :order => "date desc")
  end
  
  #returns true if the bat has a flight log on date
  def flown_on(date)
    f = Flight.find(:first, :conditions => ["bat_id = #{self.id} and date = ?", 
        date])
    if f
      return true
    else
      return false
    end
  end
  
  def flight_dates(year,month)
    flights = Flight.find(:all, :conditions => "bat_id = #{self.id} and YEAR(date) = #{year} AND MONTH(date) = #{month}", :order => "date ASC")
    dates = Array.new
    flights.each{|flight| dates << flight.date.day }
    return dates, flights
  end

  def exempt_from_flight
    if (self.medical_problems.current.length > 0) || self.species.hibernating || 
        self.quarantine? || self.has_surgeries || self.leave_date
      return true
    else
      return false
    end
  end

  def self.exempt_from_flight
    curr_bats = Bat.active

    ex_bats = Array.new
    for bat in curr_bats
      if bat.exempt_from_flight
        ex_bats << bat
      end
    end
    return ex_bats
  end
	
	
  def self.not_exempt_from_flight
    @curr_bats = Bat.active
    @curr_bats - Bat.exempt_from_flight
  end
	
  def self.in_flight_cage
    @curr_bats = Bat.active
	
    bats_flight_cage = Array.new
    for bat in @curr_bats
      if bat.cage.flight_cage
        bats_flight_cage << bat
      end
    end
    bats_flight_cage = bats_flight_cage.sort_by{|b| b.band}
    return bats_flight_cage
  end
  
  def flown_enough?(date)
    return self.exempt_from_flight || (self.flights.length >= 3 && 
      ( self.flights[-3].date >= (date - 7.days) ) )
  end

  def self.not_flown(bats)
    bats_not_flown = Array.new
    bats.each{|bat| bat.flown_enough?(Date.today) ? '' : bats_not_flown << bat}
    bats_not_flown = bats_not_flown.sort_by{|b| 
      [b.cage.user_id, b.cage.name, b.band]}
    return bats_not_flown
  end

	def has_surgeries
		!self.surgeries.empty?
	end

  #bat is in quarantine if the species requires vaccination and the bat either
  #hasn't been vaccinated or the bat's vaccination date was within 30 days of today
  #and the bat isn't deactivated
  def quarantine?
    if self.leave_date == nil && self.species.requires_vaccination && 
        (!self.vaccination_date || self.vaccination_date >= (Date.today - 30.days))
      return true
    else
      return false
    end
  end
  
  def med_problem_current_first_one_only
    med_problem = MedicalProblem.find(:first, :conditions=>{:bat_id => self.id, 
        :date_closed => nil}, :order => "date_opened")
    return med_problem
  end
  
  #single run for populating the bat changes table in the database
  def self.populate_bat_changes
    #logging the cage changes
    
    #go through all the cihs first
    cihs = CageInHistory.find(:all)
    for cih in cihs
      bat_change = BatChange.new
      bat_change.date = cih.date
      bat_change.bat = cih.bat
      bat_change.new_cage_id = cih.cage.id
      if cih.cage_out_history #might be a newly created bat which doesn't have a corresponding coh
        bat_change.old_cage_id = cih.cage_out_history.cage.id
      end
      bat_change.note = cih.note
      bat_change.user = cih.user
      bat_change.cage_in_history = cih
      bat_change.save
    end
    
    #log the cohs with no cih (deactivated bats)
    cohs = CageOutHistory.find(:all, :conditions => "cage_in_history_id is null")
    for coh in cohs
      bat_change = BatChange.new
      bat_change.date = coh.date
      bat_change.bat = coh.bat
      bat_change.old_cage_id = coh.cage.id
      bat_change.note = coh.note
      bat_change.user = coh.user
      bat_change.save
    end
    
    #logging medical_treatments
    treatments = MedicalTreatment.find(:all)
    for treatment in treatments
      bat_change = BatChange.new
      bat_change.date = treatment.date_opened
      bat_change.bat = treatment.medical_problem.bat
      bat_change.note = "STARTED TREATMENT FOR: " + treatment.medical_problem.title
			bat_change.medical_treatment = treatment
      bat_change.save
      
      if treatment.date_closed
        bat_change = BatChange.new
        bat_change.date = treatment.date_closed
        bat_change.bat = treatment.medical_problem.bat
        bat_change.note = "ENDED TREATMENT FOR: " + treatment.medical_problem.title
				bat_change.medical_treatment = treatment
        bat_change.save
      end
    end
    
    #logging owner changes
		cohs = CageOutHistory.find(:all, :conditions => "cage_in_history_id is not null")
    for coh in cohs
      if (coh.cage.user != coh.cage_in_history.cage.user) #coh is not just being deactivated and cage owners are different
				cih = coh.cage_in_history
        bat_change = BatChange.find(:first, :conditions => "date = '#{coh.date.to_date}' and bat_id = #{coh.bat.id} and cage_in_history_id = #{cih.id} and new_cage_id = #{cih.cage.id} and old_cage_id = #{coh.cage.id} and user_id = #{coh.user.id} and note = '#{coh.note}'")
				bat_change.owner_new_id = cih.cage.user.id
				bat_change.owner_old_id = coh.cage.user.id
				bat_change.save
      end
    end
  end
  
  #protocols passed in are the entire protocols that you'd like the bat to have (not just the additions to what the bat already has)
	def save_protocols(protocols,time_altered,user)

    #saving history of protocols removed
		for p_removed in (self.protocols - protocols)
      #create a protocol history
      p_hist = ProtocolHistory.new
      p_hist.bat = self
      p_hist.protocol = p_removed
      p_hist.added = false
      p_hist.date = time_altered
      p_hist.user = user
      p_hist.save
		end

    #saving history of protocols added
		for p_added in (protocols - self.protocols)
      #only make p_hist if under the protocol allowed bats
			if p_added.check_allowed_bats(Array.new(1,self))
        #create a protocol history
        p_hist = ProtocolHistory.new
        p_hist.bat = self
        p_hist.protocol = p_added
        p_hist.added = true
        p_hist.date = time_altered
        p_hist.user = user
        p_hist.save
      else
        protocols = protocols - Array.new(1,p_added)
      end
		end
		
    self.protocols = protocols
  end

  #date bat was LAST added to protocol
	def date_added_to_protocol(protocol)
		hist = ProtocolHistory.find(:last, 
      :conditions => ["protocol_id = ? and bat_id = ? and added is true", protocol.id, self.id],
      :order => "date")
		return hist.date
	end

  def self.bats_on_species(bats,species)
    Bat.all(:conditions => {:id => bats, :species_id => species.id} )
  end
  
  #used to determine the owner of the bat at a particular time
  #beware - if date passed in is during a time when the bat is deactivated, it 
  #will still return a cage
  #also note that cage_in_histories date column is a datetime variable
  def in_cage_when(date)
    cih = CageInHistory.find(:first, :conditions => 
        ['bat_id = ? and date <= ?',self.id,date],
      :order => "date desc")
    if cih
      return cih.cage
    else
      self.cage_in_histories[-1].cage
    end
  end
end
