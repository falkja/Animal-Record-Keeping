class Bat < ActiveRecord::Base
	belongs_to :cage
	belongs_to :protocol
    has_many :cage_in_histories, :order => "date desc"
    has_many :cage_out_histories, :order => "date desc"
    
    #call this whenever you think the bat's cage could have changed
    #it updates both the cage out and cage in histories as required
    #Call this BEFORE saving the bat, otherwise the memory of the original
    #cage will be lost for ever
    def log_cage_change
        
        #Here we test to see if the cage has changed
        old_bat = Bat.find(self.id)    
        
        if old_bat == nil  #we are creating a new bat
                            #we should log a cage change event
            old_cage = nil
        
        else        #we are updating an existing cage
            old_bat.cage == self.cage ? return : #nothing to see here
            old_cage = old_bat.cage #we really changed the cage
        end

        new_cage = self.cage

        #We may have to close out the last cage_in_history
        #by creating a cage_out_history and attaching it to the cage_in_history
        unless old_bat == nil
            cih = old_bat.cage_in_histories #a list of histories sorted by latest date
            if cih
                cih = cih[0]
            else
                #Somebody screwed up and we gotta clean up the mess
                cih = CageInHistory.new
                cih.bat = self
                cih.cage = old_bat.cage
                cih.save
            end
            
            coh = CageOutHistory.new
            coh.bat = self
            coh.cage = old_cage
            coh.user = @current_user #session[:person]
            coh.date = Time.new 
            coh.cage_in_history = cih
            coh.save
            
        end

        #Make a new entry in the cage in histories
        cih = CageInHistory.new
        cih.bat = self
        cih.cage = new_cage
        cih.user = @current_user #session[:person]
        cih.date = Time.new 

        cih.save
    end
    
    #called just before creation
    def before_create
        log_cage_change
    end
    
    #before_save is called automatically just before a class is saved to the db
    #Tasks
    # 1. Update the cage_out_history and cage_in_history if needed
    def before_save
        log_cage_change
    end
        
end
