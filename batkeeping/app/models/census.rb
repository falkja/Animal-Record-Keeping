class Census < ActiveRecord::Base
		belongs_to :room
		
		def tally(num_bats, room)
			self.room = room
			if self.animals != nil
				self.animals = self.animals + num_bats
			else
				last_census = Census.find(:first, :order => 'date desc', :conditions => 'room_id = ' + room.id.to_s)
				if last_census && last_census.animals
          self.animals = last_census.animals + num_bats
        else 
          self.animals = num_bats
        end
			end
			self.save
		end
end