class Bat < ActiveRecord::Base
	belongs_to :cage
	belongs_to :species
	has_many :weights, :order => "date desc"
	has_many :cage_in_histories, :order => "date desc"
	has_many :cage_out_histories, :order => "date desc"
	has_many :medical_problems, :order => "date_opened desc"
	has_many :bat_notes, :order => "date desc"
	
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
		weights = self.weights
		sum = 0
		weights.each{|weight| sum=weight.weight + sum}
    if weights.length > 0
      return (("%.0" + 1.to_s + "f")%(sum/weights.length)).to_f
    else
      return 0
    end
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
			cih = self.cage_in_histories #a list of histories sorted by latest date
			if cih
				cih = cih[0]
			else
				#Somebody screwed up and we gotta clean up the mess
				cih = CageInHistory.new
				cih.bat = self
				cih.cage = old_bat.cage
				cih.user = @@current_user #blame the current user #@current_user
				cih.note = "NOTE: This cage in event was generated automatically. No one logged this bat into this cage"
				
				cih.save
			end
			
			coh = CageOutHistory.new
			coh.bat = self
			coh.cage = old_cage
			coh.user = @@current_user
			coh.note = @@comment
			coh.date = Time.new 
			coh.cage_in_history = cih
			coh.save
			
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
	
  #returns bats that have had something change on date
  def self.changes_on(date)
    bats = Array.new
    
    #finding the bats that have moved
    cohs =  CageOutHistory.find(:all, :conditions => "YEAR(date) = #{date.year} AND MONTH(date) = #{date.month} AND DAY(date) = #{date.day}")
    for coh in cohs
      bats << coh.bat
    end
    
    #finding the bats with new medical treatments
    treatments = MedicalTreatment.find(:all, :conditions => "YEAR(date_opened) = #{date.year} AND MONTH(date_opened) = #{date.month} AND DAY(date_opened) = #{date.day}")
    for treatment in treatments
      bats << treatment.medical_problem.bat
    end
    
    bats.uniq!
    bats = bats.sort_by{|bat| [bat.band]}
    return bats
  end
  
  #returns true if the bat was moved on that day, returns false if it wasn't moved on date
  def moved_on(date)
    if self.cage_out_histories[0].date.to_date == date
      return true
    else
      return false
    end
  end
  
  #returns the medical treatments created on date
  def medical_treatments_changed_on(date)
    med_treatments = Array.new
    self.medical_problems.each{|medical_problem| medical_problem.medical_treatments.each{
      |medical_treatment| (if medical_treatment.date_opened == date then med_treatments << medical_treatment end)}}
    return med_treatments
  end
  
  #returns the weight of the bat on or before date
  def weight_on(date)
    Weight.find(:first, :conditions => "bat_id = #{self.id} and YEAR(date) <= #{date.year} AND MONTH(date) <= #{date.month} AND DAY(date) <= #{date.day}")
  end
end
