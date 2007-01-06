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
    @cage_tasks = Task.cage_tasks
    @medical_tasks = Task.medical_tasks    
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
    @users = User.current
  end

  def new_weigh_cage_task
    @cage = Cage.find(params[:id])
    @users = User.current
  end

  def create_weigh_cage_task #called from new_weigh_cage_task page
    @cage = Cage.find(params[:id])    
    @users = User.find(params[:users])
    @days = params[:days]    
            
    if @days.include?(0)  #only need one daily task
        @days.clear
        @days << 0
    end
    
    for day in @days
        @task = Task.new
        @task.repeat = day
        @task.cage = @cage
        @task.title = "Weigh cage " + @cage.name        
        @task.save
        @task.users = @users
    end    
    
    redirect_to :controller => 'cages', :action => 'show', :id => @cage 
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
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      flash[:notice] = 'Task was successfully updated.'
      redirect_to :action => 'show', :id => @task
    else
      render :action => 'edit'
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
