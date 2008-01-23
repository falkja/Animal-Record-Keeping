class Bat < ActiveRecord::Base
	belongs_to :cage
	belongs_to :species
	has_many :weights, :order => "date desc"
	has_many :cage_in_histories, :order => "date desc"
	has_many :cage_out_histories, :order => "date desc"
	has_many :medical_problems, :order => "date_opened desc"
	has_many :bat_notes, :order => "date desc"
  has_many :bat_changes, :order => "date desc"
	
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
		Weight.average(:weight, :conditions => "bat_id = #{self.id}")
	end
	
	#From http://www.therailsway.com/tags/rails
	#This lets us do Bats.active AS WELL AS cage.bats.active !
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
		bats.each{|bat| ( (bat.weights.recent.date < (Time.now - 7.days)) && bat.monitor_weight) ? bats_not_weighed << bat : ''}
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
				cih = cih[0]
			end
			
			coh = CageOutHistory.new
			coh.bat = self
			coh.cage = old_cage
			coh.user = @@current_user
			coh.note = @@comment
			coh.date = Time.new 
			new_cage ? coh.cage_in_history = cih : ''
			coh.save
      
      if new_cage == nil #old cage is not nil but new cage is nil (deactivated bat): still need to make a bat changes entry
        #making a bat changes entry for the deactivated bat
        bat_change = BatChange.new
        bat_change.date = coh.date
        bat_change.bat = coh.bat
        bat_change.old_cage_id = coh.cage.id
        bat_change.note = coh.note
        bat_change.user = coh.user
        bat_change.save
      end
		end
    
    unless new_cage == nil #will create all the bat_changes entries except when its a deactivated bat
      #making a bat changes entry for the cih
      bat_change = BatChange.new
      bat_change.date = cih.date
      bat_change.bat = cih.bat
      bat_change.new_cage_id = cih.cage.id
      if cih.cage_out_history #might be a newly created bat which doesn't have a corresponding coh
        bat_change.old_cage_id = cih.cage_out_history.cage.id
      end
      bat_change.note = cih.note
      bat_change.user = cih.user
      if old_cage #a true cage change
        if (new_cage.user != old_cage.user) #owner change
          bat_change.owner_new_id = new_cage.user.id
          bat_change.owner_old_id = old_cage.user.id
        end
      else #a newly created bat
        bat_change.owner_new_id = new_cage.user.id
      end
      bat_change.cage_in_history = cih
      bat_change.save
    end
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
		end
	end
  
  #returns the weight of the bat on or before date
  def weight_on(date)
    Weight.find(:first, :conditions => "bat_id = #{self.id} and YEAR(date) <= #{date.year} AND MONTH(date) <= #{date.month} AND DAY(date) <= #{date.day}")
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
  
end
