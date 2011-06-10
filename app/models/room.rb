class Room < ActiveRecord::Base
  has_many :cages
  has_many :weathers
	has_many :bats, :through => :cages, :order => 'band'
	has_many :tasks
	has_many :task_census

  def self.has_bats
#    rooms = Room.find(:all, :order => :name)
#    rooms.delete_if{|room| room.bats.length == 0}
#    return rooms

    cages = Cage.has_bats
    Room.find(:all, :joins=>:cages,
      :conditions=>["cages.id IN (?)",cages],
      :select => 'DISTINCT rooms.*', :order => 'name')
  end

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
  
  def species_listing
    cages = Array.new
    self.cages.each{|cage| cages << cage}
    
    bats = Array.new
    cages.each{|cage| cage.bats.each{|bat| bats << bat}}
    
    species_list = Array.new
    bats.each{|bat| species_list << bat.species.name}
    species_list = species_list.uniq
    return species_list
  end
  
  def total_feed_tasks_when(day, month, year)
    TaskCensus.find(:all, :conditions=> "room_id = #{self.id} and internal_description = 'feed' and date = '#{year}-#{month}-#{day}'")
  end
  
  def done_feed_tasks_when(day, month, year)
    TaskCensus.find(:all, :conditions=> "date_done is not null and room_id = #{self.id} and internal_description = 'feed' and date = '#{year}-#{month}-#{day}'")
  end
	
	def total_water_tasks_when(day, month, year)
		TaskCensus.find(:all, :conditions=> "room_id = #{self.id} and internal_description = 'change_water' and date = '#{year}-#{month}-#{day}'")
	end
	
	def done_water_tasks_when(day, month, year)
		TaskCensus.find(:all, :conditions=> "date_done is not null and room_id = #{self.id} and internal_description = 'change_water' and date = '#{year}-#{month}-#{day}'")
	end
	
	def total_pads_tasks_when(day, month, year)
		TaskCensus.find(:all, :conditions=> "room_id = #{self.id} and internal_description = 'change_pads' and date = '#{year}-#{month}-#{day}'")
	end
	
	def done_pads_tasks_when(day, month, year)
		TaskCensus.find(:all, :conditions=> "date_done is not null and room_id = #{self.id} and internal_description = 'change_pads' and date = '#{year}-#{month}-#{day}'")
	end
	
	def total_cages_tasks_when(day, month, year)
		TaskCensus.find(:all, :conditions=> "room_id = #{self.id} and internal_description = 'change_cages' and date = '#{year}-#{month}-#{day}'")
	end
	
	def done_cages_tasks_when(day, month, year)
		TaskCensus.find(:all, :conditions=> "date_done is not null and room_id = #{self.id} and internal_description = 'change_cages' and date = '#{year}-#{month}-#{day}'")
	end
	
	def total_floor_tasks_when(day, month, year)
		TaskCensus.find(:all, :conditions=> "room_id = #{self.id} and internal_description = 'clean_floor' and date = '#{year}-#{month}-#{day}'")
	end
	
	def done_floor_tasks_when(day, month, year)
		TaskCensus.find(:all, :conditions=> "date_done is not null and room_id = #{self.id} and internal_description = 'clean_floor' and date = '#{year}-#{month}-#{day}'")
	end
end