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
  
  #This page displays summary information about the whole colony
  def colony_page
    @cages = Cage.find(:all, :conditions => "date_destroyed is null", :order => 'room')
    
    @colony_cages = Array.new
    @colony_bats = Array.new
    for cage in @cages
      if cage.room == 'Colony Room (4100)'
        @colony_cages << cage
        for bat in cage.bats.active
        @colony_bats << bat
        end
      end
    end
    
    @belfry_cages = Array.new
    @belfry_bats = Array.new
    for cage in @cages
      if cage.room == 'Belfry (4102F)'
        @belfry_cages << cage
        for bat in cage.bats.active
        @belfry_bats << bat
        end
      end
    end
    
    @fruitbat_cages = Array.new
    @fruitbat_bats = Array.new
    for cage in @cages
      if cage.room == 'Fruit Bats (4148L)'
        @fruitbat_cages << cage
        for bat in cage.bats.active
        @fruitbat_bats << bat
        end
      end
    end
  end
end