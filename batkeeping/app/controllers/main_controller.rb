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
      redirect_to :action => 'user_summary_page'
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
      user = User.find(session[:person].id)
      @mycages = user.cages
      @mymedicalproblems = user.medical_problems.current
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
    @colony_food = 0
    @cages.each {|cage| @colony_food = @colony_food + cage.food }
    
    @colony_cages = Cage.find(:all, :conditions => 'date_destroyed is null and room = "Colony Room (4100)"', :order => 'name') 
    @colony_bats = Array.new
    @colony_cages.each {|cage| @colony_bats << cage.bats}
    @colony_bats.flatten!
    
    @belfry_cages = Cage.find(:all, :conditions => 'date_destroyed is null and room = "Belfry (4102F)"', :order => 'name') 
    @belfry_bats = Array.new
    @belfry_cages.each {|cage| @belfry_bats << cage.bats}
    @belfry_bats.flatten!
    
    @fruitbat_cages = Cage.find(:all, :conditions => 'date_destroyed is null and room = "Fruit Bats (4148L)"', :order => 'name') 
    @fruitbat_bats = Array.new
    @fruitbat_cages.each {|cage| @fruitbat_bats << cage.bats}
    @fruitbat_bats.flatten!
  end
end