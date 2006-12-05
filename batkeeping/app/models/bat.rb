class Bat < ActiveRecord::Base
	belongs_to :cage
	belongs_to :protocol
    has_many :cage_in_histories
    has_many :cage_out_histories
    
    #call this whenever the bat's cage changes 
    #it updates both the cage out and cage in histories as required
    def on_cage_change(old_cage, new_cage)
        unless old_cage == nil #which means we want to log moving in to a new cage
            @coh = CageOutHistory.new
            @coh.bat = self
            @coh.cage = old_cage
            @coh.user = @current_user #session[:person]
            @coh.date = Time.new 
            @coh.save
        end

        unless new_cage == nil #which means we want to log moving out of a cage
            @cih = CageInHistory.new
            @cih.bat = self
            @cih.cage = new_cage
            @cih.user = @current_user #session[:person]
            @coh.date = Time.new 
            @cih.save
        end

    end
    
    #after_save is called automatically after a class is saved to the db
    def before_save
        old_bat = Bat.find(self.id)
        unless old_bat.cage == self.cage
            on_cage_change(old_bat.cage, self.cage)
        end
    end
    
    #after_save is called automatically after a class is saved to the db
    #After saving a bat, if we have changed cages, we need to update
    #cage_out_history and cage_in_history
    def after_save
    end
end
