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
	redirect_to :action => 'index'
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

end