class MainController < ApplicationController
  
  def index
		@users = User.current
		@weekend_care_users = User.current_weekend_care
		@medical_care_users = User.current_medical_care
		@animal_care_users = User.current_animal_care
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

	def animal_care_staff
		@weekend_care_users = User.current_weekend_care
		@medical_care_users = User.current_medical_care
		@animal_care_users = User.current_animal_care
	end

  #lists things of relevance to only the user
  def user_summary_page
    if session[:person] != nil
      @weekend_care_users = User.current_weekend_care
      @medical_care_users = User.current_medical_care
      @animal_care_users = User.current_animal_care
      
      @user = User.find(params[:id])
      @cages = @user.cages.active
      @medical_problems = @user.bats_medical_problems
      @feeding_cages = @user.cages.has_feeding_tasks
      
      @my_medical_tasks = @user.tasks.medical_tasks
      @my_medical_tasks_today = @user.tasks.medical_tasks_today
      @my_medical_tasks_not_today = @user.tasks.medical_tasks_not_today
      
      if @user.medical_care_user?
        Task.medical_user_tasks.each{|task| @my_medical_tasks << task}
        Task.medical_user_tasks_today.each{|task| @my_medical_tasks_today << task}
        Task.medical_user_tasks_not_today.each{|task| @my_medical_tasks_not_today << task}
      end
      
      @my_general_tasks = @user.tasks.general_tasks
      @my_general_tasks_today = @user.tasks.general_tasks_today
      @my_general_tasks_not_today = @user.tasks.general_tasks_not_today
      
      @my_weighing_tasks = @user.tasks.weighing_tasks
      @my_weighing_tasks_today = @user.tasks.weighing_tasks_today
      @my_weighing_tasks_not_today = @user.tasks.weighing_tasks_not_today
      
      @my_feeding_tasks = @user.tasks.feeding_tasks
      @my_feeding_tasks_today = @user.tasks.feeding_tasks_today
      @my_feeding_tasks_not_today = @user.tasks.feeding_tasks_not_today
      
      if (@user.animal_care_user? || @user.weekend_care_user?)
        Task.animal_care_user_general_tasks.each{|task| @my_general_tasks << task}
        Task.animal_care_user_general_tasks_today.each{|task| @my_general_tasks_today << task}
        Task.animal_care_user_general_tasks_not_today.each{|task| @my_general_tasks_not_today << task}
        
        Task.animal_care_user_weighing_tasks.each{|task| @my_weighing_tasks << task}
        Task.animal_care_user_weighing_tasks_today.each{|task| @my_weighing_tasks_today << task}
        Task.animal_care_user_weighing_tasks_not_today.each{|task| @my_weighing_tasks_not_today << task}
        
        Task.animal_care_user_feeding_tasks.each{|task| @my_feeding_tasks << task}
        Task.animal_care_user_feeding_tasks_today.each{|task| @my_feeding_tasks_today << task}
        Task.animal_care_user_feeding_tasks_not_today.each{|task| @my_feeding_tasks_not_today << task}
      end
      
      @my_feeding_tasks = @my_feeding_tasks.sort_by{|task| [task.repeat_code, task.title]}
      @my_feeding_tasks_today = @my_feeding_tasks_today.sort_by{|task| [task.repeat_code, task.title]}
      @my_feeding_tasks_not_today = @my_feeding_tasks_not_today.sort_by{|task| [task.repeat_code, task.title]}
      
      @my_weighing_tasks = @my_weighing_tasks.sort_by{|task| [task.title]}
      @my_weighing_tasks_today = @my_weighing_tasks_today.sort_by{|task| [task.title]}
      @my_weighing_tasks_not_today = @my_weighing_tasks_not_today.sort_by{|task| [task.title]}
    
    else
      redirect_to :action => 'index'
    end
  end
  
  def lab_email
    @tasks_not_done = Task.tasks_not_done_today(Task.today)
    
    @users = User.current
    
    @users_emails = Array.new
    @users.each{|user| @users_emails << user.email}
    
    @subject = "Batkeeping email from: " + session[:person].name
    
    @greeting = "Dear Batlab,\n\n"
    
    if @tasks_not_done.length > 0
      @msg_body = "Tasks not done today (" + Time.now.strftime('%B %d, %Y') + "):\n\n"
      for task in @tasks_not_done
        @msg_body = @msg_body + "Task: " + task.title + "\nAssigned to: " 
        if (task.users.length > 0)
          for user in task.users
            @msg_body = @msg_body + user.name + ", "
          end
        else
          @msg_body = @msg_body + "Animal Care Staff"
        end
        @msg_body = @msg_body + "\n\n"
      end
    else
      @msg_body = "All of today's tasks completed.\n\n"
    end
    @msg_body = @msg_body + "Faithfully yours, etc."
  end
  
  def send_lab_email
    recipients = params[:users_emails]
    msg_body = params[:email][:body]
    subject = params[:email][:subject]
    
    MyMailer.deliver_mass_mail(recipients, subject, msg_body)
    
    flash[:notice] = 'Email Sent'
    redirect_to :action => 'user_summary_page', :id => session[:person]
  end
end