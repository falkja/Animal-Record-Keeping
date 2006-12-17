class Bat < ActiveRecord::Base
	belongs_to :cage
	belongs_to :protocol
    has_many :weights, :order => "date desc"
    has_many :cage_in_histories, :order => "date desc"
    has_many :cage_out_histories, :order => "date desc"
    has_many :medical_problems, :order => "date_opened desc"
    
    @@current_user = nil #needed for the sig
    @@comment = nil #needed if we wanna comment a cage move
    
    
    #From http://www.therailsway.com/tags/rails
    #This lets us do Bats.active AS WELL AS cage.bats.active !
    def self.active
        find :all, :conditions => 'leave_date is null'
    end
        
    #returns all the sick bats
    def self.sick
        @medical_problems = MedicalProblem.find(:all)
        bat_ids = Array.new
        for medical_problem in @medical_problems
            bat_ids << medical_problem.bat.id
        end
        Bat.find(bat_ids.uniq, :order => 'band')
    end
    
    #Return all bats that left the colony (leave_date)
    #on the given month (month is an integer from 1 to 12)
    def self.left_on_month(month)
        #from http://dev.mysql.com/doc/refman/5.0/en/date-calculations.html
        Bat.find(:all, :conditions => 'YEAR(leave_date) = YEAR(CURDATE()) AND MONTH(leave_date) = ' + month.to_s)
    end
    
    def self.arrived_on_month(month)
        #from http://dev.mysql.com/doc/refman/5.0/en/date-calculations.html
        Bat.find(:all, :conditions => 'YEAR(collection_date) = YEAR(CURDATE()) AND MONTH(collection_date) = ' + month.to_s)
    end
    
    
    def Bat.set_user_and_comment(user, cmt)
        @@current_user = user
        @@comment = cmt
    end
    
    #call this whenever you think the bat's cage could have changed
    #it updates both the cage out and cage in histories as required
    def log_cage_change(old_cage, new_cage)
        
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
        
end
