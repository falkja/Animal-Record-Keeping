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
    @rooms = Room.find(:all, :order=> 'name')
		
    compute_food_summary
	end

	# This prints the monthly summary sheet that used to hang in the
	# colony rooms. We need to pass through params
	# :year :month :room
	def monthly_sheet
    if (params[:date][:year] == '')
      redirect_to :back
    else
      earliest = Bat.earliest_addition
      @end_year = Time.now.year
      if earliest
        @start_year = earliest.year			
      else	
        @start_year = @end_year
      end
      @rooms = Room.find(:all, :order=> 'name')
      
      @year = params[:date][:year].to_i
      @month = params[:date][:month].to_i
      @room = Room.find(params[:room][:id])
      @days_this_month = 0...Date::civil(@year, @month, -1).day
      @tempandhumidity_list = Weather.for_date(@year, @month, @days_this_month, @room.id)
    end
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
    @medical_problems = @medical_problems.sort_by{|medical_problem| [medical_problem.bat.band]}
		render :partial => 'medical_summary'
	end
	
	def hide_medical_summary
		render :partial => 'hide_medical_summary'
	end
	
  def bat_changes
    
    earliest = Bat.earliest_addition
    @end_year = Time.now.year
    earliest ? @start_year = earliest.year : @start_year = @end_year
    
    if (params[:date] == nil)
      @year = Time.now.year
      @month = Time.now.mon
    else
      @year = params[:date][:year].to_i
      @month = params[:date][:month].to_i
    end
    
    @days_this_month = Date::civil(@year,@month,1)...Date::civil(@year, @month, -1)
  end
  
end