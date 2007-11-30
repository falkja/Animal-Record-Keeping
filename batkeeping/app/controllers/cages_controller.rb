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
    @div_id = params[:div]
    @weighing = params[:weighing]
    @list_all = params[:list_all]
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end
  
  def list_by_room
    @cages = Cage.find(params[:ids])
    @cages = @cages.sort_by{|cage| [cage.room.name, cage.name]}
    @div_id = params[:div]
    @weighing = params[:weighing]
    @list_all = params[:list_all]
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end
  
  def list_by_owner
    @cages = Cage.find(params[:ids])
    @cages = @cages.sort_by{|cage| [cage.user.name, cage.name]}
    @div_id = params[:div]
    @weighing = params[:weighing]
    @list_all = params[:list_all]
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end
  
  def list_by_bats
    @cages = Cage.find(params[:ids], :order => 'user_id, name')
    @cages = @cages.sort_by{|cage| [-cage.bats.count, cage.name]}
    @div_id = params[:div]
    @weighing = params[:weighing]
    @list_all = params[:list_all]
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end

  def list_by_bat_weight
    @cages = Cage.find(params[:ids], :order => 'user_id, name')
    @cages = @cages.sort_by{|cage| [cage.average_bat_weight, cage.name]}
    @div_id = params[:div]
    @weighing = params[:weighing]
    @list_all = params[:list_all]
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end

  def show
    @cage = Cage.find(params[:id])
    @tasks = @cage.tasks #should be the list of weighing tasks
    @cohs = @cage.cage_out_histories
  end

  def new
    @cage = Cage.new
    @deactivating = false
    @rooms = Room.find(:all, :order => 'name')
		if @rooms.length == 0
			flash[:notice] = 'New cages need a room.  Create a room before creating a cage.'
			redirect_to :controller => 'rooms', :action => :new
		end
  end

  def create
    if Cage.find(:first, :conditions => "name = '#{params[:cage][:name]}'")
      flash[:notice] = 'There is already a cage with the same name.  Please choose a different name or reactivate the old cage.'
			redirect_to :back
    elsif params[:cage][:name] == ''
			flash[:notice] = 'There were problems with your submission.  Please make sure all data fields are filled out.'
			redirect_to :back
    else
      @cage = Cage.new(params[:cage])
      @cage.date_destroyed = nil

      if @cage.save
        flash[:notice] = 'Cage was successfully created.'
        redirect_to :controller => 'cages', :action => :show, :id => @cage
      else
        render :action => 'new'
      end
    end
  end

  def edit
    @cage = Cage.find(params[:id])
    @deactivating = false
    @rooms = Room.find(:all, :order => 'name')
  end

  def update
    @cage = Cage.find(params[:id])
    #we don't want the name change propagated on an edit so we remove that from the hash
    params[:cage].delete "name"
    @deactivating = params[:deactivating]
    if @cage.update_attributes(params[:cage])
      if @deactivating
        for task in @cage.tasks
          task.deactivate
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
    @rooms = Room.find(:all, :order => 'name')
    if @cage.bats.length > 0
      flash[:notice] = 'Deactivation failed. ' + @cage.name + ' is not empty.'
      redirect_to :controller => 'bats', :action => 'choose_cage'
    elsif @cage.tasks.current.length > 0
      flash[:notice] = 'Deactivation failed. ' + @cage.name + ' still has feeding or weighing tasks.'
      redirect_to :action => 'show', :id => @cage
    end
    @deactivating = true
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
      (cage.bats.count > 0) ? @cages << cage : ''
    end
  end

  def weigh_cage
		@cage = Cage.find(params[:id])
		@cages = Cage.find(:all, :conditions => "date_destroyed is null", :order => "name" )
		@bats = @cage.bats
		
		weighing_tasks = @cage.tasks.weighing_tasks
		@updateable_tasks = Array.new
		for task in weighing_tasks
			if task.doable
				@updateable_tasks << task
			end
		end
	end
  
  def move_cage
    @cages = Cage.active
  end
  
  def choose_room
    cage = Cage.find(params[:cage])
    rooms = Room.find(:all, :conditions => "id != " + cage.room.id.to_s)
    render :partial=>'choose_room', :locals => {:cage=>cage, :rooms=>rooms}
  end
  
  def move_cage_summary
    cage = Cage.find(params[:cage])
    new_room = Room.find(params[:room])
    render :partial => 'move_cage_summary', :locals=>{:cage=>cage, :new_room=>new_room}
  end
  
  def submit_move_cage
    cage = Cage.find(params[:cage])
    old_room = Room.find(cage.room)
    cage.room = Room.find(params[:room])
    cage.save
    
    old_census = Census.find_or_create_by_date_and_room_id(Date.today, old_room)
    old_census.tally(-cage.bats.length, Date.today, old_room)			
    for bat in cage.bats
      old_census.bats_removed ? old_census.bats_removed = old_census.bats_removed + bat.band + ' ' : old_census.bats_removed = bat.band + ' '
    end
    old_census.save
      
    new_census = Census.find_or_create_by_date_and_room_id(Date.today, cage.room)
    new_census.tally(cage.bats.length, Date.today, cage.room)
    for bat in cage.bats
      new_census.bats_added ? new_census.bats_added = new_census.bats_added + bat.band + ' ' : new_census.bats_added = bat.band + ' '
    end
    new_census.save
		
		for task in cage.tasks
			task.room = cage.room
			task.save
		end
    
		cage.tasks.today.each{|task| TaskCensus.room_swap(cage.room,task)}
		
    flash[:notice] = 'Cage ' + cage.name + ' was moved from ' + old_room.name + ' to ' + cage.room.name
    redirect_to :action => 'move_cage'
  end
end
