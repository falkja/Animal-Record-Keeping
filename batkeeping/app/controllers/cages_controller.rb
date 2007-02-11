class CagesController < ApplicationController
  def index
    redirect_to :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @cages = Cage.find(:all, :conditions => 'date_destroyed is null', :order => 'name')
    @list_all = false
    @div_id = 'cages_div'
  end
  
  def list_all
    @cages = Cage.find(:all, :order => 'name')
    @list_all = true
    @div_id = 'cages_div'
    render :action => 'list'
  end
  
  def list_by_name
    @cages = Cage.find(params[:ids], :order => 'name')
    @list_all = false
    @div_id = params[:div]
    @weighing = params[:weighing]
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end

  def list_all_by_name
    @cages = Cage.find(params[:ids], :order => 'name')
    @list_all = true
    @div_id = params[:div]
    @weighing = params[:weighing]
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end
  
  def list_by_room
    @cages = Cage.find(params[:ids], :order => 'room, name')
    @list_all = false
    @div_id = params[:div]
    @weighing = params[:weighing]
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end
  
  def list_all_by_room
    @cages = Cage.find(params[:ids], :order => 'room, name')
    @list_all = true
    @div_id = params[:div]
    @weighing = params[:weighing]
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end
  
  def list_by_owner
    @cages = Cage.find(params[:ids], :order => 'user_id, name')
    @list_all = false
    @div_id = params[:div]
    @weighing = params[:weighing]
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end
  
  def list_all_by_owner
    @cages = Cage.find(params[:ids], :order => 'user_id, name')
    @list_all = true
    @div_id = params[:div]
    @weighing = params[:weighing]
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end
  
  def show
    @cage = Cage.find(params[:id])
    @tasks = @cage.tasks #should be the list of weighing tasks
    cihs = @cage.cage_in_histories
    @cohs = Array.new
    for cih in cihs
        coh = cih.cage_out_history
        coh ? @cohs << coh : ''
    end    
  end

  def new
    @cage = Cage.new
	@deactivating = false
  end

  def create
    @cage = Cage.new(params[:cage])
	@cage.date_destroyed = nil

    if @cage.save
      flash[:notice] = 'Cage was successfully created.'
      redirect_to :controller => 'tasks', :action => 'new_weigh_cage_task', :id => @cage
    else
      render :action => 'new'
    end
  end

  def edit
    @cage = Cage.find(params[:id])
	@deactivating = false
  end

  def update
    @cage = Cage.find(params[:id])
    #we don't want the name change propagated on an edit so we remove that from the hash
    params[:cage].delete "name"
    @deactivating = params[:deactivating]
    if @cage.update_attributes(params[:cage])
      if @deactivating
        for task in @cage.tasks
          task.destroy
        end
      end
      flash[:notice] = 'Cage was successfully updated.'
      if params[:redirectme] == 'list'
        redirect_to :action => 'list'
      else
        redirect_to :action => 'show', :id => @cage
      end
    else
      render :action => 'edit'
    end
  end

  def destroy
    Cage.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def deactivate
	@cage = Cage.find(params[:id])
  if @cage.bats.count == 0
    @deactivating = true
  else
    flash[:notice] = @cage.name + ' was not empty.  Please move bats before deactivating cage.'
    redirect_to :controller => 'bats', :action => 'cage_change', :id => @cage
  end
  end
  
  def reactivate
	@cage = Cage.find(params[:id])
	@cage.date_destroyed = nil
	@cage.save
	redirect_to :controller => 'tasks', :action => 'new_weigh_cage_task', :id => @cage
  end

  def choose_cage_to_weigh
       @all_cages = Cage.find(:all, :conditions => "date_destroyed is null", :order => "name")
       @cages = Array.new
	for cage in @all_cages
	  if cage.bats.count > 0 
		  @cages << cage
	  end
	end
  end

  def weigh_cage
	@cage = Cage.find(params[:id])
    @cages = Cage.find(:all, :conditions => "date_destroyed is null", :order => "name" )
	@bats = @cage.bats
end
end
