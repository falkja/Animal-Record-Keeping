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
	  session[:person] = params[:user][:id]
	  flash[:notice] = "Welcome " + User.find(session[:person]).name
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
		@animal_care_staff_page = true
    
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
      @bats = @user.bats
	  	  
      @medical_problems = @user.bats_medical_problems
      @medical_problems = @medical_problems.sort_by{|medical_problem| [medical_problem.bat.cage.name, medical_problem.bat.band, medical_problem.title]}
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
      
      @my_feeding_tasks = @user.tasks.feeding_tasks
      @my_feeding_tasks_today = @user.tasks.feeding_tasks_today
      @my_feeding_tasks_not_today = @user.tasks.feeding_tasks_not_today
      
      if (@user.animal_care_user? || @user.weekend_care_user?)
        Task.animal_care_user_general_tasks.each{|task| @my_general_tasks << task}
        Task.animal_care_user_general_tasks_today.each{|task| @my_general_tasks_today << task}
        Task.animal_care_user_general_tasks_not_today.each{|task| @my_general_tasks_not_today << task}
        
        Task.animal_care_user_feeding_tasks.each{|task| @my_feeding_tasks << task}
        Task.animal_care_user_feeding_tasks_today.each{|task| @my_feeding_tasks_today << task}
        Task.animal_care_user_feeding_tasks_not_today.each{|task| @my_feeding_tasks_not_today << task}
      end
    
    else
      redirect_to :action => 'index'
    end
  end
  
  def lab_email
    
    @users = User.find(params[:users], :order => "name asc")
    
    @greeting = "Dear Batlab,\n\n"
    
    @greeting = @greeting + Time.now.strftime('%A, %B %d, %Y') + "\n\n"

    @msg_body = MyMailer.create_msg_body(Task.tasks_not_done_today(Task.today),
      Bat.not_weighed(Bat.active,Time.now),Bat.not_flown(Bat.active),ProtocolHistory.todays_histories,
      BatChange.deactivated_today,Bat.not_vaccinated(Bat.active))

    if session[:person]
      @subject = "Batkeeping email from: " + User.find(session[:person]).name
      @msg_body = @msg_body + "This message brought to you by,\n\n" + User.find(session[:person]).name
    else
      @subject = "Batkeeping email"
      @msg_body = @msg_body + "This message brought to you by,\n\nBatkeeping (no user signed in)"
    end
    
  end
  
  def send_lab_email
    users = User.find(params[:users])
    recipients = Array.new
    users.each{|user| recipients << user.email}
    
    msg_body = params[:email][:body]
    subject = params[:email][:subject]
    
    MyMailer.deliver_mass_mail(recipients, subject, msg_body)
    
    flash[:notice] = 'Email Sent'
    redirect_to :action => 'user_summary_page', :id => User.find(session[:person])
  end
  
end