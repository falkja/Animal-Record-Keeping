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
  
  @todays_weather = Weather.today
  
  if session[:person] != nil
	  @user = User.find(params[:id])
	  @mycages = @user.cages.active
		
    if params[:id] == '3' #weekend care gets all the medical problems and medical tasks
      @medical_problems = MedicalProblem.current
      @my_medical_tasks_today = Task.medical_tasks_today
      @my_medical_tasks_not_today = Task.medical_tasks_not_today
      @my_medical_tasks = Task.medical_tasks
      @weekend = 'weekend'
    else
      @medical_problems = Array.new
			@user.tasks.medical_tasks.each{|task| @medical_problems << task.medical_treatment.medical_problem}
      @medical_problems.uniq!
      @my_medical_tasks_today = @user.tasks.medical_tasks_today
      @my_medical_tasks_not_today = @user.tasks.medical_tasks_not_today
      @my_medical_tasks = @user.tasks.medical_tasks
      @weekend = ''
	  end

		@medical_problems = @medical_problems.sort_by{|medical_problem| [medical_problem.bat.band, medical_problem.title]}

	  @my_general_tasks_today = @user.tasks.general_tasks_today
	  @my_weighing_tasks_today = @user.tasks.weighing_tasks_today
	  @my_feeding_tasks_today = @user.tasks.feeding_tasks_today
	
	  @my_general_tasks_not_today = @user.tasks.general_tasks_not_today
	  @my_weighing_tasks_not_today = @user.tasks.weighing_tasks_not_today
	  @my_feeding_tasks_not_today = @user.tasks.feeding_tasks_not_today
    
    @my_general_tasks = @user.tasks.general_tasks
	  @my_weighing_tasks = @user.tasks.weighing_tasks
	  @my_feeding_tasks = @user.tasks.feeding_tasks
    
    @feeding_cages = @user.cages.has_feeding_tasks
    @cages = @mycages
	else
	  redirect_to :action => 'index'
	end
  end
end