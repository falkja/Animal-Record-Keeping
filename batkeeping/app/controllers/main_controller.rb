class MainController < ApplicationController
  def index
	@users = User.find(:all, :order => "name")
  end

  def cage_change
	@cages = Cage.find(:all, :conditions => "date_destroyed is null", :order => "name")
	@bats = Bat.find(:all, :conditions => "leave_date is null", :order => "band")
  end

  def move
	@bats = Bat.find(params[:bat][:id])
	@cage = Cage.find(params[:cage][:id])
	@cage.bats << @bats 
	@cage.bats = @cage.bats.uniq
  end
  
  def login
	session[:person] = User.find(params[:user][:id])
	redirect_to :action => 'index'
  end
  
  def logout
	session[:person] = nil
	redirect_to :action => 'index'
  end
  
end
