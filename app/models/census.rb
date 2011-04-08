class Census < ActiveRecord::Base
		belongs_to :room
		
		def tally(num_bats, date, room)
			self.room = room
			if self.animals != nil
				self.animals = self.animals + num_bats
			else
				last_census = Census.find(:first, :order => 'date desc', :conditions => "room_id = #{room.id.to_s} and date < '#{date}'")
				if last_census && last_census.animals
          self.animals = last_census.animals + num_bats
        else 
          self.animals = num_bats
        end
			end
			self.save
		end
		
		def self.update_after(num_bats, date, room)
			censi =Census.find(:all, :conditions => "date > '#{date}' and room_id = #{room.id.to_s}")
			for census in censi
				census.animals = census.animals + num_bats
				census.save
			end
		end
end