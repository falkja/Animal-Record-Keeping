class CagesController < ApplicationController
  def index
    redirect_to :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
    :redirect_to => { :action => :list }

  def list
    if params[:cages]
      @cages = Cage.find(params[:cages])
    else
      @cages = Cage.find(:all, :conditions => 'date_destroyed is null', :order => 'name')
    end
    @list_all = false
    @div_id = 'cages_div'
  end
  
  def list_deactivated
    @cages = Cage.find(:all, :conditions => 'date_destroyed is not null', :order => 'name')
    @list_all = false
    @div_id = 'cages_div'
    render :action => 'list'
  end
  
  def list_all
    @cages = Cage.find(:all, :order => 'name')
    @list_all = true
    @div_id = 'cages_div'
    render :action => 'list'
  end
  
  def initialize_values_for_list
    @div_id = params[:div]
    @weighing = params[:weighing]
    @list_all = params[:list_all]
  end
  
  def list_by_name
    @cages = Cage.find(params[:ids], :order => 'name')
    initialize_values_for_list
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end
  
  def list_by_room
    @cages = Cage.find(params[:ids])
    @cages = @cages.sort_by{|cage| [cage.room.name, cage.name]}
    initialize_values_for_list
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end
  
  def list_by_owner
    @cages = Cage.find(params[:ids])
    @cages = @cages.sort_by{|cage| [cage.user.name, cage.name]}
    initialize_values_for_list
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end
  
  def list_by_bats
    @cages = Cage.find(params[:ids], :order => 'user_id, name')
    @cages = @cages.sort_by{|cage| [-cage.bats.count, cage.name]}
    initialize_values_for_list
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end

  def list_by_bat_weight
    @cages = Cage.find(params[:ids], :order => 'user_id, name')
    @cages = @cages.sort_by{|cage| [cage.average_bat_weight, cage.name]}
    initialize_values_for_list
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end
  
  def list_by_weigh_date
    @cages = Cage.find(params[:ids], :order => 'user_id, name')
	  @cages = @cages.sort_by{|cage| [cage.last_weigh_date.to_f, cage.name]}
    initialize_values_for_list
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end
  
  def list_by_flown
    @cages = Cage.find(params[:ids], :order => 'user_id, name')
    @cages = @cages.sort_by{|cage| 
      [(cage.last_flown == nil ? 0 : cage.last_flown.to_time.to_f), cage.name]}
    initialize_values_for_list
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end
  
  def list_by_feed_tasks
    @cages = Cage.find(params[:ids], :order => 'user_id, name')
    @cages = @cages.sort_by{|cage| cage.tasks.feeding_tasks.length}
    initialize_values_for_list
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end
  
  def list_by_flight_cage
    @cages = Cage.find(params[:ids], :order => 'flight_cage desc, user_id, name')
    initialize_values_for_list
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end

  def list_by_med
    @cages = Cage.find(params[:ids], :order => 'user_id, name')
    @cages = @cages.sort_by{|cage| -cage.current_medical_problems.length}
    initialize_values_for_list
    render :partial => 'cage_list', :locals => {:cage_list => @cages}
  end
  
  def show
    @cage = Cage.find(params[:id])
    @tasks = @cage.tasks #should be the list of weighing tasks
    
    @current_bats_cihs = Array.new
    for bat in @cage.bats
      @current_bats_cihs << bat.cage_in_histories[0]
    end
    
    @old_bats_cohs = @cage.cage_out_histories
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
    @cage = Cage.new(params[:cage])
    @cage.date_destroyed = nil

    if @cage.save
      flash[:notice] = 'Cage was successfully created.'
      redirect_to :controller => 'cages', :action => :show, :id => @cage
    else
      render :action => 'new'
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
    old_owner_id = @cage.user_id
    if @cage.update_attributes(params[:cage])
      
      if old_owner_id != @cage.user_id #owner change requres a new bat changes entry
        for bat in @cage.bats
          bat_change = BatChange.new      
          bat_change.date = Date.today
          bat_change.bat = bat
          bat_change.note = ''
          bat_change.user = User.find(session[:person])
          bat_change.owner_new_id = @cage.user.id
          bat_change.owner_old_id = old_owner_id
					bat_change.note = "Owner Change"
          bat_change.save
        end
      end
      
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
      redirect_to :controller => :bats, :action => :move_bats
    elsif @cage.tasks.current.length > 0
      flash[:notice] = 'Deactivation failed. ' + @cage.name + ' still has feeding or weighing tasks.'
      redirect_to :action => :show, :id => @cage
    end
    @deactivating = true
  end
  
  def reactivate
    @cage = Cage.find(params[:id])
    @cage.date_destroyed = nil
    @cage.save
    redirect_to :controller => :cages, :action => :list
  end

  def choose_cage_to_weigh
    if params[:cages]
      @cages = Cage.find(params[:cages], :order => "name")
    else
      @all_cages = Cage.active
      @cages = Array.new
      for cage in @all_cages
        (cage.bats.count > 0) ? @cages << cage : ''
      end
    end
  end

  def weigh_cage
		@cage = Cage.find(params[:id])
		@cages = Cage.find(:all, :conditions => "date_destroyed is null", :order => "name" )
		@bats = @cage.bats
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
