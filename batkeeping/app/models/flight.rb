class Flight < ActiveRecord::Base
	belongs_to :bat
	belongs_to :user
	
	def self.populate_daily_flight_logs
		today = Date.today
		
		bats = Bat.active
		for bat in bats
			if !bat.flown_on(today)
				if bat.cage.flight_cage
					flight=Flight.new
					flight.bat = bat
					flight.user = bat.cage.user
					flight.date = today
					flight.note = 'Flight Cage'
					flight.save
				elsif bat.exempt_from_flight
					flight=Flight.new
					flight.bat = bat
					flight.user = bat.cage.user
					flight.date = today
					flight.exempt = true
					flight.note = 'Exempt'
					flight.save
				end
			end
		end
	end
end