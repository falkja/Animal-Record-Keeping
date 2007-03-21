class TasksController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @general_tasks_today = Task.general_tasks_today
	  @weighing_tasks_today = Task.weighing_tasks_today
	  @feeding_tasks_today = Task.feeding_tasks_today
	  @medical_tasks_today = Task.medical_tasks_today
	  @general_tasks_not_today = Task.general_tasks_not_today
	  @weighing_tasks_not_today = Task.weighing_tasks_not_today
	  @feeding_tasks_not_today = Task.feeding_tasks_not_today
	  @medical_tasks_not_today = Task.medical_tasks_not_today
    @general_tasks = Task.general_tasks
    @weighing_tasks = Task.weighing_tasks
    @feeding_tasks = Task.feeding_tasks
    @medical_tasks = Task.medical_tasks
    
    @feeding_cages = Cage.has_feeding_tasks
    @cages = Cage.has_bats
    @medical_problems = MedicalProblem.current
  end
  
  def hide_tasks
    if params[:source].include? 'weekend'
      @user = User.find('3')
    else
      @user = User.find(session[:person].id)
    end
    
    params[:medical_tasks] ? medical_tasks = Task.find(params[:medical_tasks]) : medical_tasks = Array.new
    params[:general_tasks] ? general_tasks = Task.find(params[:general_tasks]) : general_tasks = Array.new
    
    if (params[:source].include? 'user_summary') && (params[:div_id].include? 'todays_tasks')
      weighing_tasks = @user.tasks.weighing_tasks_today
      feeding_tasks = @user.tasks.feeding_tasks_today
    elsif (params[:source].include? 'user_summary') && (params[:div_id].include? 'other_tasks')
      weighing_tasks = @user.tasks.weighing_tasks_not_today
      feeding_tasks = @user.tasks.feeding_tasks_not_today
    elsif (params[:source].include? 'user_summary') && (params[:div_id].include? 'all_tasks')
      weighing_tasks = @user.tasks.weighing_tasks
      feeding_tasks = @user.tasks.feeding_tasks
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'todays_tasks')
      weighing_tasks = Task.weighing_tasks_today
      feeding_tasks = Task.feeding_tasks_today
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'other_tasks')
      weighing_tasks = Task.weighing_tasks_not_today
      feeding_tasks = Task.feeding_tasks_not_today
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'all_tasks')
      weighing_tasks = Task.weighing_tasks
      feeding_tasks = Task.feeding_tasks
    end
    
		params[:feeding_cages] ? feeding_cages = Cage.find(params[:feeding_cages]) : feeding_cages = Array.new
		params[:medical_problems] ? medical_problems = MedicalProblem.find(params[:medical_problems]) : medical_problems = Array.new
		params[:cages] ? cages = Cage.find(params[:cages]) : cages = Array.new
		
	  render :partial => 'hide_tasks', :locals => {:general_tasks => general_tasks, :weighing_tasks => weighing_tasks, :feeding_tasks => feeding_tasks,
									:medical_tasks => medical_tasks, :div_id => params[:div_id], :feeding_cages => feeding_cages,
									:cages => cages, :medical_problems => medical_problems, :single_cage_task_list => params[:single_cage_task_list], :source => params[:source]}
  end
  
  def show_tasks
    if params[:source].include? 'weekend'
      @user = User.find('3')
    else
      @user = User.find(session[:person].id)
    end
    
    params[:medical_tasks] ? medical_tasks = Task.find(params[:medical_tasks]) : medical_tasks = Array.new
    params[:general_tasks] ? general_tasks = Task.find(params[:general_tasks]) : general_tasks = Array.new
    
    if (params[:source].include? 'user_summary') && (params[:div_id].include? 'todays_tasks')
      weighing_tasks = @user.tasks.weighing_tasks_today
      feeding_tasks = @user.tasks.feeding_tasks_today
    elsif (params[:source].include? 'user_summary') && (params[:div_id].include? 'other_tasks')
      weighing_tasks = @user.tasks.weighing_tasks_not_today
      feeding_tasks = @user.tasks.feeding_tasks_not_today
    elsif (params[:source].include? 'user_summary') && (params[:div_id].include? 'all_tasks')
      weighing_tasks = @user.tasks.weighing_tasks
      feeding_tasks = @user.tasks.feeding_tasks
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'todays_tasks')
      weighing_tasks = Task.weighing_tasks_today
      feeding_tasks = Task.feeding_tasks_today
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'other_tasks')
      weighing_tasks = Task.weighing_tasks_not_today
      feeding_tasks = Task.feeding_tasks_not_today
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'all_tasks')
      weighing_tasks = Task.weighing_tasks
      feeding_tasks = Task.feeding_tasks
    end
    
		params[:feeding_cages] ? feeding_cages = Cage.find(params[:feeding_cages]) : feeding_cages = Array.new
		params[:medical_problems] ? medical_problems = MedicalProblem.find(params[:medical_problems]) : medical_problems = Array.new
		params[:cages] ? cages = Cage.find(params[:cages]) : cages = Array.new
		
	  render :partial => 'show_tasks', :locals => {:general_tasks => general_tasks, :weighing_tasks => weighing_tasks, :feeding_tasks => feeding_tasks,
									:medical_tasks => medical_tasks, :div_id => params[:div_id], :feeding_cages => feeding_cages,
									:cages => cages, :medical_problems => medical_problems, :single_cage_task_list => params[:single_cage_task_list], :source => params[:source]}
  end

  def show
    @task = Task.find(params[:id])
  end

  def choose_new_task
    @cages = Cage.has_bats
    @medical_problems = MedicalProblem.current
  end

  def new
    @task = Task.new
    @users = User.current
  end

  #called from the form on the list tasks page, needed so that the page that is requested has an ID attached to it so that refreshes of the page don't break
  def form_to_new_weigh_cage_task
    @cage = Cage.find(params[:id])
    redirect_to :action => 'new_weigh_cage_task', :id => @cage
  end

  def remote_new_weigh_cage_task
    @cage = Cage.find(params[:id])
    @users = User.current
    
    render :partial => 'remote_new_weigh_cage_task', :locals => {:cage => @cage, :div_id => params[:div_id], :source => params[:source], 
                                                                                            :single_cage_task_list => params[:single_cage_task_list]}
  end

  def new_weigh_cage_task
    @cage = Cage.find(params[:id])
    @users = User.current
  end

  def create_weigh_cage_task #called from new_weigh_cage_task page
    @cage = Cage.find(params[:id])
    @users = User.find(params[:users])
    @days = params[:days]    
            
    if @days.include?("0")  #only need one daily task
        @days.clear
        @days << "0"
    end
    
    for day in @days
      @task = Task.new
      @task.repeat_code = day
      @task.cage = @cage
      @task.title = "Weigh cage " + @cage.name    
      @task.internal_description = "weigh"
      @task.jitter = -1
      @task.date_started = Time.now
      @task.save
      if @users.include?(User.find(1)) && ((day == "1") || (day == "7") || (day == "0"))  #General Animal Care can't do tasks on weekend - add to weekend/holiday care
        @task.users << User.find(3)
        @task.users << @users
        @task.users.uniq
      elsif @users.include?(User.find(3)) && ((day == "2") || (day == "3") || (day == "4") || (day == "5") || (day == "6") || (day == "0")) #Weekend Care can't do tasks on weekdays - add to general animal care
        @task.users << User.find(1)
        @task.users << @users
        @task.users.uniq
      else
        @task.users = @users
      end
    end
    
    if params[:source].include? 'weekend'
      @user = User.find('3')
    else
      @user = User.find(session[:person].id)
    end
    
    if (params[:source].include? 'user_summary') && (params[:div_id].include? 'todays_tasks')
      weighing_tasks = @user.tasks.weighing_tasks_today
    elsif (params[:source].include? 'user_summary') && (params[:div_id].include? 'other_tasks')
      weighing_tasks = @user.tasks.weighing_tasks_not_today
    elsif (params[:source].include? 'user_summary') && (params[:div_id].include? 'all_tasks')
      weighing_tasks = @user.tasks.weighing_tasks
    elsif params[:source] == 'show_cage'
      weighing_tasks = @cage.tasks.weighing_tasks
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'todays_tasks')
      weighing_tasks = Task.weighing_tasks_today
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'other_tasks')
      weighing_tasks = Task.weighing_tasks_not_today
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'all_tasks')
      weighing_tasks = Task.weighing_tasks
    end
    
    render :partial => 'tasks_list', :locals => {:tasks_list => nil, :tasks => weighing_tasks, 
                                      :div_id => params[:div_id], :single_cage_task_list => params[:single_cage_task_list], :manage => true}
  end


  #allows editing the food amount and dishes for multiple feeding tasks
  def form_to_edit_multiple_feeding_tasks
    @cage = Cage.find(params[:id])
    redirect_to :action => :edit_multiple_feeding_tasks, :id => @cage
  end
  
  def edit_multiple_feeding_tasks
    @cage = Cage.find(params[:id])
  end
	  
  def update_multiple_feeding_tasks
    @cage = Cage.find(params[:id])
    
    for task in @cage.tasks.feeding_tasks
        task.food = params[:task][:food]
        task.dish_type = params[:task][:dish_type]
        task.dish_num = params[:task][:dish_num]
        task.save
    end    
    
    render :partial => 'tasks_list', :locals => {:tasks_list => nil, :tasks => @cage.tasks.feeding_tasks, :div_id => 'feeding_tasks', 
                            :single_cage_task_list => true, :manage => true}
  end
  
  #called from the form on the list tasks page, needed so that the page that is requested has an ID attached to it so that refreshes of the page don't break
  def form_to_new_feed_cage_task
    @cage = Cage.find(params[:id])
    redirect_to :action => 'new_feed_cage_task', :id => @cage
  end

  def new_feed_cage_task
    @cage = Cage.find(params[:id])
    @users = User.current
  end

  def remote_new_feed_cage_task
    @cage = Cage.find(params[:id])
    @users = User.current
    
    render :partial => 'remote_new_feed_cage_task', :locals => {:cage => @cage, :div_id => params[:div_id], :source => params[:source], :single_cage_task_list => params[:single_cage_task_list]}
  end

  def create_feed_cage_task #called from new_feed_cage_task page
    @cage = Cage.find(params[:id])
    @users = User.find(params[:users])
    @days = params[:days]
            
    if @days.include?("0")  #need to convert to multiple tasks
        @days.clear
        @days = ["1","2","3","4","5","6","7"]
    end
    
    for day in @days
      @task = Task.new
      @task.repeat_code = day
      @task.cage = @cage
      @task.title = "Feed cage " + @cage.name    
      @task.internal_description = "feed"
      @task.food = params[:task][:food]
      @task.dish_type = params[:task][:dish_type]
      @task.dish_num = params[:task][:dish_num]
      @task.jitter = 0
      @task.date_started = Time.now
      @task.save
      if (@users.include?(User.find(1)) && ((day == "1") || (day == "7")))  #General Animal Care can't do tasks on weekend - add to weekend/holiday care
        @task.users << User.find(3)
        @task.users << @users
        @task.users.uniq
      elsif @users.include?(User.find(3)) && ((day == "2") || (day == "3") || (day == "4") || (day == "5") || (day == "6")) #Weekend Care can't do tasks on weekdays - add to general animal care
        @task.users << User.find(1)
        @task.users << @users
        @task.users.uniq
      else
      @task.users = @users
      end
    end

    if params[:source].include? 'weekend'
      @user = User.find('3')
    else
      @user = User.find(session[:person].id)
    end

    if (params[:source].include? 'user_summary') && (params[:div_id].include? 'todays_tasks')
      feeding_tasks = @user.tasks.feeding_tasks_today
    elsif (params[:source].include? 'user_summary') && (params[:div_id].include? 'other_tasks')
      feeding_tasks = @user.tasks.feeding_tasks_not_today
    elsif (params[:source].include? 'user_summary') && (params[:div_id].include? 'all_tasks')
      feeding_tasks = @user.tasks.feeding_tasks
    elsif params[:source] == 'show_cage'
      feeding_tasks = @cage.tasks.feeding_tasks
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'todays_tasks')
      feeding_tasks = Task.feeding_tasks_today
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'other_tasks')
      feeding_tasks = Task.feeding_tasks_not_today
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'all_tasks')
      feeding_tasks = Task.feeding_tasks
    end
	#feeding_tasks.sort_by{|task| [task.repeat_code]}

    render :partial => 'tasks_list', :locals => {:tasks_list => nil, :tasks => feeding_tasks, 
                                      :div_id => params[:div_id], :single_cage_task_list => params[:single_cage_task_list], :manage => true}
  end

  def new_medical_task
    @medical_problem = MedicalProblem.find(params[:id])
    @deactivating = false
  end

  def create_medical_task
    medical_problem = MedicalProblem.find(params[:id])
    task = Task.new(params[:task])
    task.medical_problem = medical_problem
    task.repeat_code = 0
    task.internal_description = "medical"
    task.jitter = 0
    task.date_started = Time.now
    if task.save
      task.users << medical_problem.user
      flash[:notice] = 'Medical Treatment successfully created.'
      redirect_to :controller => 'medical_problems', :action => 'list'
    else
      render :action => 'new'
    end
  end

	def do_medical_task
		@task = Task.find(params[:id])
	end
	
  def create
    @users = User.find(params[:users][:id])
    @days = params[:days]
            
    if @days.include?("0")  #only need one daily task
        @days.clear
        @days << "0"
    end
    
    for day in @days
        @task = Task.new(params[:task])
        @task.repeat_code = day
        @task.internal_description = nil
		@task.date_started = Time.now
        @task.save
        @task.users = @users
    end
    redirect_to :action => 'list'
  end

  def edit
    @task = Task.find(params[:id])
    @users = User.current
    @user_ids = Array.new 
    @task.users.each {|user| @user_ids << user.id }
    @editing = true
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      @task.users = User.find(params[:users][:id])
      flash[:notice] = 'Task was successfully updated.'
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end

  #only saves tasks if they are on the due date (feeding) or within 2 days of the deadline (all others)
  def done
    task = Task.find(params[:id])
    Task::set_current_user(session[:person])
    task.done
    render :partial => 'tasks_list', :locals => {:tasks_list => nil, :tasks => Task.find(params[:ids], :order => 'repeat_code'), :div_id => params[:div_id], :single_cage_task_list => params[:single_cage_task_list], :manage => true}
  end
  
  def medical_task_done
    task = Task.find(params[:id])
		
		task_history = TaskHistory.new(params[:task_history])
		task_history.user = session[:person]
		task_history.task = task
		task_history.save
		
		weight = Weight.new
		weight.bat = task.medical_problem.bat
		weight.date = task_history.date_done
		weight.user = session[:person]
		weight.weight = params[:bat][:weight]
    if params[:checkbox][:after_eating] == '1'
      weight.after_eating = 'y'
    else
      weight.after_eating =  'n'
    end
		weight.save
		task_history.weight = weight
		
    redirect_to :controller => 'medical_problems', :action => 'list'
  end
  
  def destroy
    tasks = Task.find(params[:ids], :order => 'repeat_code')
    tasks.delete(Task.find(params[:id]))
    Task.find(params[:id]).deactivate
    render :partial => 'tasks_list', :locals => {:tasks_list => nil, :tasks => tasks, :div_id => params[:div_id], :single_cage_task_list => params[:single_cage_task_list], :manage => true}
  end
  
  def destroy_medical_task
    Task.find(params[:id]).deactivate
    redirect_to :controller => 'medical_problems', :action => 'list'
  end
  
  def clear_tasks
    tasks = Task.find(params[:tasks])
    for task in tasks
	    task.date_ended = Time.now
      task.save
    end
    render :partial => 'tasks_list', :locals => {:tasks_list => nil, :tasks => [], :div_id => params[:div_id], :single_cage_task_list => params[:single_cage_task_list], :manage => params[:manage]}
  end
  
end
