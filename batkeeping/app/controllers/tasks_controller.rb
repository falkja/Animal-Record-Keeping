class TasksController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @tasks = Task.find(:all)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
    @users = User.current
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
