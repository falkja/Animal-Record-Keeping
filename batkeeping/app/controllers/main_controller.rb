class MainController < ApplicationController
  
  def index
	@users = User.find(:all, :conditions => "end_date is null", :order => "name")
  end
  
  #just show all cage changes
  def cage_change_histories
	@cih = CageInHistory.find(:all, :order => "date")
	@coh = CageOutHistory.find(:all, :order => "date")
  end
  
  def login
	  session[:person] = User.find(params[:user][:id])
	  flash[:notice] = "Welcome " + User.find(session[:person].id).name
	  redirect_to :action => 'user_summary_page', :id => params[:user][:id]
  end
  
  def logout
	session[:person] = nil
	redirect_to :action => 'index'
  end
  
  def timeout
	session[:person] = nil
	flash[:notice] = "Session timed out."
	redirect_to :action => 'index'
  end

  #lists things of relevance to only the user
  def user_summary_page
	if session[:person] != nil
	  @user = User.find(params[:id])
	  @mycages = @user.cages.active
	  @mymedicalproblems = @user.medical_problems.current
	  
    @my_general_tasks_today = @user.tasks.general_tasks_today
	  @my_weighing_tasks_today = @user.tasks.weighing_tasks_today
	  @my_feeding_tasks_today = @user.tasks.feeding_tasks_today
    
    @my_general_tasks_not_today = @user.tasks.general_tasks_not_today
	  @my_weighing_tasks_not_today = @user.tasks.weighing_tasks_not_today
	  @my_feeding_tasks_not_today = @user.tasks.feeding_tasks_not_today
	else
	  redirect_to :action => 'index'
	end
  end
  
  #This page displays what the weekend care person has to do.
  def weekend_care
  @sick_bats = Bat.sick
  
	@user = User.find(3)
  general_tasks = @user.tasks.general_tasks
  @saturday_general_tasks = Array.new
  @sunday_general_tasks = Array.new
  for task in general_tasks
    (task.repeat_code == 7 or task.repeat_code == 0) ? @saturday_general_tasks << task : ''
    (task.repeat_code == 1 or task.repeat_code == 0) ? @sunday_general_tasks << task : ''
  end
  feeding_tasks = @user.tasks.feeding_tasks
  @saturday_feeding_tasks = Array.new
  @sunday_feeding_tasks = Array.new
  for task in feeding_tasks
    (task.repeat_code == 7 or task.repeat_code == 0) ? @saturday_feeding_tasks << task : ''
    (task.repeat_code == 1 or task.repeat_code == 0) ? @sunday_feeding_tasks << task : ''
  end
  end
	
	#This page displays summary information about the whole colony
	def colony_page
		compute_census_summary
		compute_food_summary
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
		@colony_cages = Cage.active_colony_cages
		@colony_bats = bats_in_cages(@colony_cages)
	
		@belfry_cages = Cage.active_belfry_cages
		@belfry_bats = bats_in_cages(@belfry_cages)
	
		@fruitbat_cages = Cage.active_fruitbat_cages
		@fruitbat_bats = bats_in_cages(@fruitbat_cages)
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
	
	def admin
	end
	
	#Generate a lot of random data for testing
	def testing_data
		
		#create random cages
		rooms = ['Belfry (4102F)', 'Colony Room (4100)', 'Fruit Bats (4148L)']
		users = User.current
		for n in 1..10
			cage = Cage.new
			cage.name = "random#{n}"
			cage.room = rooms[rand(3)]
			cage.date_created = Date.new(2000+rand(6),rand(12)+1,rand(27)+1)
			cage.user = users[rand(users.length)]
			if rand(10) > 8
				cage.date_destroyed = cage.date_created + rand(365)
			end
			cage.save
		end
		
		
		#create random bats and assign them to random cages
		col_band = ("a".."z").to_a
		cages = Cage.active
		for n in 1..80
			bat = Bat.new
			bat.band = "#{col_band[rand(col_band.size-1)]}#{rand(20)}"
			bat.species = 'Eptesicus fuscus'
			bat.gender = 'M'
			bat.collection_age = 'Adult'
			bat.collection_date = Date.new(2000+rand(6),rand(12)+1,rand(27)+1)
			bat.collection_place = 'erewhon'
			if rand(10) > 8
				bat.leave_date = bat.collection_date + rand(365)
			end			
			bat.cage = cages[rand(cages.length)]
			bat.save
		end
		
		#create random feeding tasks with random food
		for n in 1..20
			task = Task.new
			task.cage = cages[rand(cages.length)] 
			task.date_started = task.cage.date_created + rand(365)
			task.internal_description = 'feed'
			task.food = rand(50)
			task.dish_type = 'Gigantic'
			task.dish_num = 2
			task.title = 'random'
			task.jitter = 3
			task.repeat_code = rand(8)
			if rand(10) > 8
				task.date_ended = task.date_started + rand(100)
			end			
			task.save
		end
		
		#create random temp and humidity entries
		for n in 1..1600
			tandh = Weather.new
			tandh.log_date = Date.new(2003 + rand(5),rand(12)+1,rand(27)+1)
			tandh.temperature = rand(30) + 10
			tandh.humidity = rand(100)
			tandh.room = rooms[rand(3)]
			tandh.sig = 'random'
			tandh.save
		end
		
		
		redirect_to :controller => 'bats', :action => 'list'
	end
	
	def erase_testing_data
		Cage.destroy_all "name like 'random%'"
		Bat.destroy_all "collection_place = 'erewhon'"
		Task.destroy_all "title = 'random'"
		Weather.destroy_all "sig = 'random'"
		redirect_to :controller => 'bats', :action => 'list'		
	end
		
	
end