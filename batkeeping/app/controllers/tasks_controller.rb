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
    @cages = Cage.has_bats
    @medical_problems = MedicalProblem.current
  end

  def show
    @task = Task.find(params[:id])
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
        @task.save
        @task.users = @users
    end    
    
    @tasks = @cage.tasks.weighing_tasks
    render_partial 'cages/weighing_tasks'
  end

  #allows editing the food amount and dishes for multiple feeding tasks
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
    
    @tasks = @cage.tasks.feeding_tasks
    render_partial 'cages/feeding_tasks'
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
        @task.save
        if (@users.include?(User.find(1)) && ((day == "1") || (day == "7")))  #General Animal Care can't do feeding tasks on weekend - assign to weekend/holiday care
          @task.users = [User.find(3)]
        else
          if @users.include?(User.find(3)) && ((day == "2") || (day == "3") || (day == "4") || (day == "5") || (day == "6"))
            @task.users = [User.find(1)]
          else
            @task.users = @users
          end
        end
    end    
    
    @tasks = @cage.tasks.feeding_tasks
    render_partial 'cages/feeding_tasks'
  end

  def create
    @task = Task.new(params[:task])
    if @task.save
      @task.users = User.find(params[:users][:id])
      flash[:notice] = 'Task was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @task = Task.find(params[:id])
    @users = User.current
    @user_ids = Array.new 
    @task.users.each {|user| @user_ids << user.id }
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
    @task = Task.find(params[:id])
    if @task.internal_description == 'feed'
      if Date.today.yday == @task.find_post
        @task.last_done_date = Time.now
        @task.save
      end
    else
      if Date.today.yday >= @task.find_post && Date.today.yday <= @task.find_post + 2
        @task.last_done_date = Time.now
        @task.save
      end
    end
    redirect_to :back
  end
  
  def destroy
    Task.find(params[:id]).destroy
    redirect_to :back
  end
end
