class Room < ActiveRecord::Base
    has_many :cages
    has_many :weathers
		has_many :tasks
    
  #returns the number of bats at any day for a given room
	def num_bats_when(day, month, year)
    recent_census = Census.find(:first, :conditions => "(date <= '" + year.to_s + "-"+ month.to_s + "-" + day.to_s + "') and room_id = " + self.id.to_s, :order => 'date desc')
    recent_census ? num_bats = recent_census.animals : num_bats = 0
		return num_bats
	end
  
  def bats_added_when(day, month, year)
    todays_census = Census.find(:first, :conditions => "(date = '" + year.to_s + "-"+ month.to_s + "-" + day.to_s + "') and room_id = " + self.id.to_s, :order => 'date desc')
    (todays_census && todays_census.bats_added) ? bats = todays_census.bats_added : bats = '-'
		return bats
	end
  
  def bats_removed_when(day, month, year)
    todays_census = Census.find(:first, :conditions => "(date = '" + year.to_s + "-"+ month.to_s + "-" + day.to_s + "') and room_id = " + self.id.to_s, :order => 'date desc')
    (todays_census && todays_census.bats_removed) ? bats = todays_census.bats_removed : bats = '-'
		return bats
	end
  
end