class TasksController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @general_tasks = Task.general_tasks
    @weighing_tasks = Task.weighing_tasks
    @medical_tasks = Task.medical_tasks
    @feeding_tasks = Task.feeding_tasks
    @feeding_cages = Cage.has_feeding_tasks
    @cages = Cage.has_bats
    @medical_problems = MedicalProblem.current
    @single_cage_task_list = false
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
      
    render :partial => 'tasks_list', :locals => {:tasks_list => nil, :tasks => @cage.tasks.weighing_tasks, :div_id => 'weighing_tasks', 
                                      :single_cage_task_list => true, :manage => false}
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
    
    render :partial => 'tasks_list', :locals => {:tasks_list => nil, :tasks => @cage.tasks.feeding_tasks, 
                                      :div_id => 'feeding_tasks', :single_cage_task_list => true, :manage => true}
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
  
  def destroy
    tasks = Task.find(params[:ids], :order => 'repeat_code')
    tasks.delete(Task.find(params[:id]))
    Task.find(params[:id]).deactivate
    render :partial => 'tasks_list', :locals => {:tasks_list => nil, :tasks => tasks, :div_id => params[:div_id], :single_cage_task_list => params[:single_cage_task_list], :manage => true}
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
