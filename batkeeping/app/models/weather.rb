class Weather < ActiveRecord::Base
    
    #Return all temp/humidity measurements for given month and year
	#Since we need to line up the measurements we return an array with
	#31,30 or 28 days as needed
    def self.for_date(year, month, day_list, room)
		
		temp_humid = Array.new
		day_list.each do |d|
			temp_humid << Weather.find( :first, :conditions => "YEAR(log_date) = #{year} AND MONTH(log_date) = #{month} AND DAY(log_date) = #{d} AND room = '#{room}'")
		end
		
        return temp_humid
    end
                    
end
