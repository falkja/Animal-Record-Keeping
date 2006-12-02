class MainController < ApplicationController
  def index
	@users = User.find(:all, :conditions => "end_date is null", :order => "name")
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
