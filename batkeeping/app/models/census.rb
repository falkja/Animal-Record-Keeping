class Census < ActiveRecord::Base
		belongs_to :room
		
		def tally(num_bats, room, date)
			self.room = room
			if self.animals != nil
				self.animals = self.animals + num_bats
			else
				last_census = Census.find(:first, :order => 'date', :conditions => 'room_id = ' + room.id.to_s)
				self.animals = last_census.animals + num_bats
			end
			self.save
		end
end