class BatsController < ApplicationController
  require "gruff"
  def index
    redirect_to :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
		 :redirect_to => { :action => :list }

	#Only list the active bats
  def list
    @bats = Bat.active
    @list = "current"
  end
  
  def list_all
    @bats = Bat.find(:all, :order => 'band')
    @list = "all"
		@show_leave_date_and_reason = true
    render :action => 'list'
  end

	def list_deactivated
		@bats = Bat.find(:all, :conditions => 'leave_date is not null', :order => 'band')
		@list = "deactivated"
		@show_leave_date_and_reason = true
		render :action => 'list'
	end

	def sort_by_species
		bat_list = Bat.find(params[:ids])
		bat_list = bat_list.sort_by{|bat| [bat.species.name, bat.band]}
    render :partial => 'bat_list', :locals => {
					:bat_list => bat_list, :div_id => params[:div_id],
					:show_leave_date_and_reason => params[:show_leave_date_and_reason],
					:show_weigh_link => params[:show_weigh_link]}
	end
	
	def sort_by_gender
		bat_list = Bat.find(params[:ids], :order => 'gender, band')
    render :partial => 'bat_list', :locals => {
					:bat_list => bat_list, :div_id => params[:div_id],
					:show_leave_date_and_reason => params[:show_leave_date_and_reason],
					:show_weigh_link => params[:show_weigh_link]}
	end
	
	def sort_by_weight
		bat_list = Bat.find(params[:ids])
		bat_list = bat_list.sort_by{|bat| [bat.weights.recent_never_nil.weight, bat.band]}
    render :partial => 'bat_list', :locals => {
					:bat_list => bat_list, :div_id => params[:div_id],
					:show_leave_date_and_reason => params[:show_leave_date_and_reason],
					:show_weigh_link => params[:show_weigh_link]}
	end

  def sort_by_band
    bat_list = Bat.find(params[:ids], :order => 'band')
    render :partial => 'bat_list', :locals => {
					:bat_list => bat_list, :div_id => params[:div_id], 
					:show_leave_date_and_reason => params[:show_leave_date_and_reason],
					:show_weigh_link => params[:show_weigh_link]}
  end
  
  def sort_by_cage
    bat_list = Bat.find(params[:ids])
		bat_list = bat_list.sort_by{|bat| [bat.cage_never_nil.name, bat.band]}
    render :partial => 'bat_list', :locals => {
					:bat_list => bat_list, :div_id => params[:div_id],
					:show_leave_date_and_reason => params[:show_leave_date_and_reason],
					:show_weigh_link => params[:show_weigh_link]}
  end
	
	def sort_by_collected
    bat_list = Bat.find(params[:ids], :order => 'collection_date, band')
    render :partial => 'bat_list', :locals => {
					:bat_list => bat_list, :div_id => params[:div_id],
					:show_leave_date_and_reason => params[:show_leave_date_and_reason],
					:show_weigh_link => params[:show_weigh_link]}
	end
  
  def show
	@bat = Bat.find(params[:id])
  @cihs = @bat.cage_in_histories
  end

  def new
		@cages = Cage.active
		@bat = Bat.new
		@species = Species.find(:all)
		@reactivating = false
		@deactivating = false
		@creating = true
		@species = Species.find(:all)
		if @cages.length == 0
			flash[:notice] = 'New bats need a cage.  Create a cage before creating a bat.'
			redirect_to :controller => 'cages', :action => :new
		end
		if @species.length == 0
			flash[:notice] = 'New bats need a species.  Create a species before creating a bat.'
			redirect_to :controller => 'species', :action => :new
		end
	end

  def create
		if (params[:bat][:cage_id] == nil) || (params[:bat][:band] == '') || (params[:bat][:collection_place] == '')
			flash[:notice] = 'There were problems with your submission.  Please make sure all data fields are filled out.'
			redirect_to :back
    elsif Bat.find(:first, :conditions => "band = '#{params[:bat][:band]}'")
      flash[:notice] = 'There is already a bat with the same band.  Please choose a different band.'
			redirect_to :back
		else
    @bat = Bat.new(params[:bat])
    @bat.leave_date = nil
		Bat::set_user_and_comment(session[:person], 'new bat') #Do this before saving!
    if @bat.save
      
			new_cage=Cage.find(params[:bat][:cage_id])
			
			#census stuff
			census = Census.find_or_create_by_date_and_room_id(Date.today, new_cage.room)
			census.tally(1, new_cage.room)
			census.bats_added ? census.bats_added = census.bats_added + @bat.band + ' ' : census.bats_added = @bat.band + ' '
			census.save
      
			flash[:notice] = 'Bat was successfully created.'
      @bats = Array.new
      @bats << @bat
      redirect_to :action => 'move', :bats => @bats, :new_cage => new_cage, :old_cage => nil, :note => 'new bat'
    else
      render :action => 'new'
    end
		end
  end

  def edit
	@current_user = session[:person]  
	@cages = Cage.active
	@bat = Bat.find(params[:id])
	@species = Species.find(:all)
	@deactivating = false
  end

  def update
    if ( (params[:bat][:band] == '') || (params[:bat][:collection_place] == '') ) && !@deactivating && !@reactivating
      flash[:notice] = 'There were problems with your submission.  Please make sure all data fields are filled out.'
      redirect_to :back
    elsif !@deactivating && !@reactivating && Bat.find(:first, :conditions => "band = '#{params[:bat][:band]}'")
      flash[:notice] = 'There is already a bat with the same band.  Please choose a different band.'
			redirect_to :back
    else 
      @bat = Bat.find(params[:id])
      if @reactivating
        note = 'reactivated'
      elsif (params[:move] != nil)
        note = params[:move][:note]
      else
        note = ''
      end
      
      Bat::set_user_and_comment(session[:person], note) #Do this before saving!
      
      if @bat.update_attributes(params[:bat])
        flash[:notice] = 'Bat was successfully updated.'
        if params[:redirectme] == 'list'
          redirect_to :action => 'list'
        elsif params[:redirectme] == 'move'
          @bats = Array.new
          @bats << @bat
          redirect_to :action => 'move', :bats => @bats, :new_cage => @bat.cage, :old_cage => @cage, :note => note
        else
          redirect_to :action => 'show', :id => @bat
        end
      else
        render :action => 'edit'
      end
    end
  end

  def destroy
	Bat.find(params[:id]).destroy
	redirect_to :action => 'list'
  end
  
  def deactivate
	@cages = Cage.find(:all, :conditions => "date_destroyed is null", :order => "name" )
	@bat = Bat.find(params[:id])
	@species = Species.find(:all)
	@deactivating = true
  end
  
  #the simplest way to handle cage leave event is like this
  def deactivate_bat
		@bat = Bat.find(params[:id])
		@cage = Cage.find(@bat.cage)
		params[:move]['note'] = params[:move]['note']
		params[:bat]['cage_id'] = nil
		@deactivating = true
	
		#census stuff
	
		census = Census.find_or_create_by_date_and_room_id(Date.today, @cage.room)
		census.tally(-1, @cage.room)
		census.bats_removed ? census.bats_removed = census.bats_removed + @bat.band + ' ' : census.bats_removed = @bat.band + ' '
		census.save
    
    for medical_problem in @bat.medical_problems.current
      medical_problem.date_closed = @bat.leave_date
      medical_problem.save
      for treatment in medical_problem.medical_treatments.current
        treatment.date_closed = @bat.leave_date
        treatment.save
        for task in treatment.tasks.current
          task.date_ended = @bat.leave_date
          task.save
        end
      end
    end
    
		update
  end
  
  def reactivate
    @bat = Bat.find(params[:id])
		@species = Species.find(:all)
    @cages = Cage.find(:all, :conditions => "date_destroyed is null", :order => "name" )
    @reactivating = true
  end
  
  #because now we need to choose a cage for the zombie bat!
  def reactivate_bat
    if params[:bat] == nil
      flash[:notice] = "Reactivation failed.  Choose a cage for your reactivated bat."
      redirect_to :back
    else
      @bat = Bat.find(params[:id])
      @bat.leave_date = nil
      @bat.leave_reason = nil
      @bat.save
      @cage = nil
		
      @bat.cage = Cage.find(params[:bat][:cage_id])
      @reactivating = true
	
      #census stuff
      census = Census.find_or_create_by_date_and_room_id(Date.today, @bat.cage.room)
      census.tally(1, @bat.cage.room)
      census.bats_added ? census.bats_added = census.bats_added + @bat.band + ' ' : census.bats_added = @bat.band + ' '
      census.save
	
      update
    end
  end

  #choose a cage to move bats from
  def choose_cage
    @cages = Cage.has_bats
  end

  #choose bats to move from cage
  def choose_bats
    cage = Cage.find(params[:id])
		bats = Array.new
		for bat in cage.bats
			bats << bat
		end
		if params[:selected_bats] != nil
			selected_bats = Bat.find(params[:selected_bats])
			for bat in selected_bats
				bats.delete(bat)
			end
		else
			selected_bats = Array.new
		end
    render :partial => 'choose_bats_to_move', :locals => {:cage => cage, :bats => bats, :selected_bats => selected_bats}
  end

	def add_bat_to_move_list
    cage = Cage.find(params[:id])
		bats = Array.new
		for bat in cage.bats
			bats << bat
		end
		bat_to_add = Bat.find(params[:bat_to_add])
		if params[:selected_bats] != nil
			selected_bats = Bat.find(params[:selected_bats])
			selected_bats << bat_to_add
			for bat in selected_bats
				bats.delete(bat)
			end
		else
			selected_bats = Array.new
			selected_bats << bat_to_add
			bats.delete(bat_to_add)
		end
		selected_bats = selected_bats.sort_by{|bat| [bat.band]}
		render :partial => 'choose_bats_to_move', :locals => {:cage => cage, :bats => bats, :selected_bats => selected_bats}
	end

	def remove_bat_from_move_list
    cage = Cage.find(params[:id])
		bats = Array.new
		for bat in cage.bats
			bats << bat
		end
		bat_to_remove = Bat.find(params[:bat_to_remove])
		selected_bats = Bat.find(params[:selected_bats])
		selected_bats.delete(bat_to_remove)
		for bat in selected_bats
			bats.delete(bat)
		end
		render :partial => 'choose_bats_to_move', :locals => {:cage => cage, :bats => bats, :selected_bats => selected_bats}
	end

  def choose_destination
    bats = Bat.find(params[:bats], :order => 'band')
    cage = Cage.find(params[:id])
    cages = Cage.find(:all, :conditions => "date_destroyed is null and id != " + cage.id.to_s, :order => "name")
    render :partial => 'choose_destination_cage', :locals => {:old_cage => cage, :bats => bats, :cages => cages}
  end

  #move a set of bats from one cage to another
  def display_move
    bats = Bat.find(params[:bats])
    new_cage = Cage.find(params[:new_cage])
    old_cage = Cage.find(params[:old_cage])
    render :partial => 'display_move_parameters', :locals => {:bats => bats, :new_cage => new_cage, :old_cage => old_cage}
  end

  def move
    @bats = Bat.find(params[:bats])
    params[:new_cage] ? @new_cage = Cage.find(params[:new_cage]) : ''
    params[:old_cage] ? @old_cage = Cage.find(params[:old_cage]) : ''
    params[:move] ? @note = params[:move][:note] : @note = params[:note]

    Bat::set_user_and_comment(session[:person],@note) #This must come before we mess with the list of bats for a cage. The moment we mess with the list, the cage and bat variables are updated. 
    if (@new_cage) && (@old_cage)
      @new_cage.bats << @bats
      @new_cage.bats = @new_cage.bats.uniq #no duplicates
      
      if @old_cage.room != @new_cage.room
        old_census = Census.find_or_create_by_date_and_room_id(Date.today, @old_cage.room)
        old_census.tally(-@bats.length, @old_cage.room)
        for bat in @bats
          old_census.bats_removed ? old_census.bats_removed = old_census.bats_removed + bat.band + ' ' : old_census.bats_removed = bat.band + ' '
        end
        old_census.save
        
        new_census = Census.find_or_create_by_date_and_room_id(Date.today, @new_cage.room)
        new_census.tally(@bats.length, @new_cage.room)
        for bat in @bats
          new_census.bats_added ? new_census.bats_added = new_census.bats_added + bat.band + ' ' : new_census.bats_added = bat.band + ' '
        end
        new_census.save
      end
    end
		
    #when we finally get emails working uncomment the following
    #MyMailer.deliver_mail("falk.ben@gmail.com")
  end
	
  def single_bat_to_move
    bat = Bat.find(params[:id])
    @bats = Array.new
    @bats << bat
    @cages = Cage.find(:all, :conditions => "date_destroyed is null and id != " + bat.cage.id.to_s, :order => "name")
    @cage = bat.cage
  end
  
	def manage_cage_tasks_after_move		
		render :partial=> 'manage_cage_tasks_after_move', :locals=>{:step=>params[:step].to_i,:old_cage=>Cage.find(params[:old_cage]), :new_cage => Cage.find(params[:new_cage])}
	end

	def manage_cage_tasks_after_deactivate_or_reactivate
		render :partial=> 'manage_cage_tasks_after_deactivate_or_reactivate', :locals=>{:step=>params[:step].to_i,:cage=>Cage.find(params[:cage]), :deactivating => params[:deactivating]}
	end

  def choose_bat_to_weigh
    @bats = Bat.active
  end
  
  def weigh_bat
    @bat = Bat.find(params[:id])
    @cages = Cage.find(:all, :conditions => "date_destroyed is null", :order => "name" )
  end
  
  def submit_weight
    @bat = Bat.find(params[:id])
    if params[:weight][@bat.id.to_s] == ''
      flash[:notice] = 'Submission failed. No weight entered.'
      redirect_to :back
    else
      #enter weights
      @cage = @bat.cage
      weight = Weight.new
      weight.bat = @bat
      weight.date = Time.now
      weight.user = session[:person]
      weight.weight = params[:weight][@bat.id.to_s] #The hash key is actually a string, so we need to convert the id to a string
      weight.note = params[:note][@bat.id.to_s]
      if params[:checkbox][:after_eating] == '1'
        weight.after_eating = 'y'
      else
        weight.after_eating =  'n'
      end
      weight.save
      
      Task::set_current_user(session[:person])
      @updated_tasks = @cage.update_weighing_tasks
      
      if params[:redirectme]
        redirect_to :controller => 'cages', :action => 'weigh_cage', :id => params[:redirectme]
      end
    end
  end
  
  def graph_weights
    bat = Bat.find(params[:id])
    weight_classes = bat.weights
    weights = Array.new
    dates = Hash.new
    dates_reduced = Hash.new
    n = 0
    weight_classes.reverse_each {|weight| weights << weight.weight; dates[n] = weight.date.strftime('%m-%d-%y'); n = n + 1;}
    
    spacing = (dates.length/6.0).ceil
    
    0.step( dates.length, spacing) {|i|  dates_reduced[i] = dates[i] }
    
    g = Gruff::Line.new(800)
    
    g.title = "Bat Weights"
    bat.species.lower_weight_limit ? g.baseline_value = bat.species.lower_weight_limit : ''
    g.data(bat.band, weights)
    g.minimum_value = 0
    
    g.labels = dates_reduced #this is where we will need to put the dates
    
    send_data(g.to_blob, :disposition => 'inline', :type => 'image/png', :filename => bat.band + " weights.png")
  
  end
  
  def add_bat_note
		@bat = Bat.find(params[:id])
    if params[:bat][:note] == ''
      render :partial => 'bats/display_bat_notes'
    else
      if @bat.note != nil
        @bat.note = @bat.note + '<tr><td>' + params[:bat][:note] + '</td><td>' + session[:person].initials + '</td><td>' + Time.now.strftime('%b %d, %Y') + '</td></tr>'
      else
        @bat.note = '<tr><td>' + params[:bat][:note] + '</td><td>' + session[:person].initials + '</td><td>' + Time.now.strftime('%b %d, %Y') + '</td></tr>'
      end
      @bat.save
      render :partial => 'bats/display_bat_notes'
    end
	end

	def show_or_hide_vaccination_date
		render :partial => 'form_vaccination', :locals=>{:bat=>Bat.find(params[:bat]), :show_vaccination_date_select=>params[:show_vaccination_date_select], 
				:reactivating=>params[:reactivating]}
	end
	
	def clear_vaccination_date
		bat = Bat.find(params[:bat])
		bat.vaccination_date = nil
		bat.save
		render :partial => 'form_vaccination', :locals=>{:bat=>bat, :show_vaccination_date_select=>false, 
				:reactivating=>params[:reactivating]}
	end
	

end