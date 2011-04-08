class Weather < ActiveRecord::Base
    belongs_to :room
    
    def self.today
      Weather.find(:first, :conditions => "log_date = '" + Date.today.to_s + "'")
    end
    
    
    #Return all temp/humidity measurements for given month and year
    #Since we need to line up the measurements we return an array with
    #31,30 or 28 days as needed
    def self.for_date(year, month, day_list, room_id)
      temp_humid = Array.new
      
      day_list.each do |d|
        temp_humid << Weather.find(:first, :conditions => "YEAR(log_date) = #{year} AND MONTH(log_date) = #{month} AND DAY(log_date) = #{d+1} AND room_id = #{room_id}")
      end
      
      return temp_humid
    end
    
end
