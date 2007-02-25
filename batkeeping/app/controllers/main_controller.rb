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
  
  def menubar_task_display
    render :partial => 'layouts/menubar_task_display', :locals => {:selected_menu => params[:selected_menu]}
  end
end