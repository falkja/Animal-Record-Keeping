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
	  @my_general_tasks = @user.tasks.general_tasks
	  @my_weighing_tasks = @user.tasks.weighing_tasks
	  @my_medical_tasks = @user.tasks.medical_tasks
	  @my_feeding_tasks = @user.tasks.feeding_tasks
	else
	  redirect_to :action => 'index'
	end
  end
  
  #lists global things of interest to everyone
  def notices_page
  end
  
  #This page displays what the weekend care person has to do.
  def weekend_care
	@sick_bats = Bat.sick
	@colony_cages = Cage.find(:all, :conditions => 'date_destroyed is null and fed_by = "Animal Care" and room = "Colony Room (4100)"') 
	@belfry_cages = Cage.find(:all, :conditions => 'date_destroyed is null and fed_by = "Animal Care" and room = "Belfry (4102F)"')     
	@fruitbat_cages = Cage.find(:all, :conditions => 'date_destroyed is null and fed_by = "Animal Care" and room = "Fruit Bats (4148L)"') 
  end
	
  #This page displays summary information about the whole colony
	def colony_page
		@cages = Cage.active
	
		@colony_food_today = 0
		@cages.each {|cage| @colony_food_today = @colony_food_today + cage.food_today }        
	
	end

	def room_summary
		@colony_cages = Cage.active_colony_cages
		@colony_bats = bats_in_cages(@colony_cages)
	
		@belfry_cages = Cage.active_belfry_cages
		@belfry_bats = bats_in_cages(@belfry_cages)
	
		@fruitbat_cages = Cage.active_fruitbat_cages
		@fruitbat_bats = bats_in_cages(@fruitbat_cages)
		render_partial 'room_summary'
	end
	
	def hide_room_summary
		render_partial 'hide_room_summary'
	end
	
	
end