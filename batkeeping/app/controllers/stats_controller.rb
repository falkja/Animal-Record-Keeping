# This controller is responsible for handling the statistics/census
# accounting of the colony
#
class StatsController < ApplicationController
  
	def index
		earliest = Bat.earliest_addition
		@end_year = Time.now.year
		if earliest
			@start_year = earliest.year			
		else	
			@start_year = @end_year
		end

		compute_census_summary
		compute_food_summary
	end

	# This prints the monthly summary sheet that used to hang in the
	# colony rooms. We need to pass through params
	# :year :month :room
	def monthly_sheet
		@year = params[:date][:year].to_i
		@month = params[:date][:month].to_i
		@room = params[:room][:number]
		@days_this_month = 0...Date::civil(@year, @month, -1).day
		@tempandhumidity_list = Weather.for_date(@year, @month, @days_this_month, @room)
	end
	
	def compute_census_summary
		bats_left, @n_bats_left_this_month = Bat.left_on_month(Time.now.month, Time.now.year)
		bats_arrived, @n_bats_arrived_this_month = Bat.arrived_on_month(Time.now.month, Time.now.year)
	end
	
	def compute_food_summary
		@cages = Cage.active
	
		@colony_food_today = 0
		@colony_food_this_week = 0
		for cage in @cages
			@colony_food_today = @colony_food_today + cage.food_today
			@colony_food_this_week = @colony_food_this_week + cage.food_this_week
		end	
	end
	
	def room_summary
		@rooms = Room.find(:all, :order=> 'name')
		render :partial => 'room_summary'
	end
	
	def hide_room_summary
		render :partial => 'hide_room_summary'
	end

	def census_summary
		earliest = Bat.earliest_addition
		if earliest 
			@years = earliest.year..Time.now.year
		else	
			@years = Array.new
		end
		compute_census_summary
		render :partial => 'census_summary'
	end
	
	def hide_census_summary
		compute_census_summary
		render :partial => 'hide_census_summary'
	end
	
	#need to pass the year in :year and yes or no in :display
	def show_census_year		
		render :partial => 'census_year_data', :locals => {:census_year_data => nil, :year => params[:year], :display => params[:display]}
	end
	
	
	def food_summary
		compute_food_summary
		render :partial => 'food_summary'
	end
	
	def hide_food_summary
		@cages = Cage.active
		
		@colony_food_today = 0
		@colony_food_this_week = 0
		for cage in @cages
			@colony_food_today = @colony_food_today + cage.food_today
			@colony_food_this_week = @colony_food_this_week + cage.food_this_week
		end				
		render :partial => 'hide_food_summary'
	end
	
	def medical_summary
		@medical_problems = MedicalProblem.current		
		render :partial => 'medical_summary'
	end
	
	def hide_medical_summary
		render :partial => 'hide_medical_summary'
	end
	
end