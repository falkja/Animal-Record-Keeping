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
		if @cages.length == 0
			flash[:notice] = 'New bats need a cage.  Create a cage before creating a bat.'
			redirect_to :controller => 'cages', :action => :new
		elsif @species.length == 0
			flash[:notice] = 'New bats need a species.  Create a species before creating a bat.'
			redirect_to :controller => 'species', :action => :new
		end
		@weight = Weight.new
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
				census.tally(1, Date.today, new_cage.room)
				census.bats_added ? census.bats_added = census.bats_added + @bat.band + ' ' : census.bats_added = @bat.band + ' '
				census.save
				
				if params[:weight][:weight] != ''
					save_weight
				end
				
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
    elsif !@deactivating && !@reactivating && (Bat.find(:all, :conditions => "band = '#{params[:bat][:band]}'").length > 1)
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
		params[:bat][:leave_reason] = params[:move][:note]
		params[:bat][:cage_id] = nil
		@deactivating = true
		
		date = Date.civil(params[:bat]["leave_date(1i)"].to_i, params[:bat]["leave_date(2i)"].to_i, params[:bat]["leave_date(3i)"].to_i)
		
		#census stuff
		census = Census.find_or_create_by_date_and_room_id(date, @cage.room)
		census.tally(-1, date, @cage.room)
		census.bats_removed ? census.bats_removed = census.bats_removed + @bat.band + ' ' : census.bats_removed = @bat.band + ' '
		census.save
		
		Census.update_after(-1, date, @cage.room)
		
    for medical_problem in @bat.medical_problems.current
      medical_problem.date_closed = date
      medical_problem.save
      for treatment in medical_problem.medical_treatments.current
        treatment.date_closed = date
        treatment.save
        for task in treatment.tasks.current
          task.date_ended = date
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
      census.tally(1, Date.today, @bat.cage.room)
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
        old_census.tally(-@bats.length, Date.today, @old_cage.room)
        for bat in @bats
          old_census.bats_removed ? old_census.bats_removed = old_census.bats_removed + bat.band + ' ' : old_census.bats_removed = bat.band + ' '
        end
        old_census.save
        
        new_census = Census.find_or_create_by_date_and_room_id(Date.today, @new_cage.room)
        new_census.tally(@bats.length, Date.today, @new_cage.room)
        for bat in @bats
          new_census.bats_added ? new_census.bats_added = new_census.bats_added + bat.band + ' ' : new_census.bats_added = bat.band + ' '
        end
        new_census.save
      end
    end
		
		msg_body = "This is a confirmation to email to notify you that the following bats: "
		for bat in @bats
			msg_body = msg_body + bat.band + ' '
		end
		if @old_cage && @new_cage
			msg_body = msg_body + "were moved from " + @old_cage.name + " to " + @new_cage.name
		elsif @new_cage
			msg_body = msg_body + "were moved into " + @new_cage.name
		else
			msg_body = msg_body + "were deactivated and moved out of " + @old_cage.name
		end
		msg_body = msg_body + "\n\nFaithfully yours, etc."		
		
    if @new_cage
      greeting = "Hi " + @new_cage.user.name + ",\n\n"
      MyMailer.deliver_mail(@new_cage.user.email, "moved bats", greeting + msg_body)
    end
    if (@old_cage && !@new_cage) || (@old_cage && @new_cage && (@new_cage.user != @old_cage.user))
			greeting = "Hi " + @old_cage.user.name + ",\n\n"
			MyMailer.deliver_mail(@old_cage.user.email, "moved bats", greeting + msg_body)
		end
		
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
		@bat.weights.today ? @weight = @bat.weights.today : @weight = Weight.new
  end
	
  def weigh_date
    render :partial => 'show_weigh_date'
  end
  
  def submit_weight
    @bat = Bat.find(params[:id])
		if params[:weight][:weight] == ''
      flash[:notice] = 'Submission failed. No weight entered.'
			redirect_to :back
			return false
    else
			save_weight
			if params[:redirectme]
				redirect_to :controller => 'cages', :action => 'weigh_cage', :id => params[:redirectme]
			end
		end
  end
  
	def todays_weight_exists
		bat = Bat.find(params[:id])
		if params[:new_weight]
			@weight = Weight.new
		else
			@weight = bat.weights.today
		end
		render :partial => 'weigh_one_bat', :locals => {:bat => bat, :initial_weight => params[:initial_weight]}
	end
	
	def save_weight
		@cage = @bat.cage
		
		if params[:weight][:new_weight] || params[:weight]["date(1i)"] 
			weight = Weight.new
		else
			@bat.weights.today ? weight = @bat.weights.today : weight = Weight.new
		end
    
		weight.bat = @bat
		params[:weight]["date(1i)"] ? weight.date = Time.local(params[:weight]["date(1i)"].to_i, params[:weight]["date(2i)"].to_i, params[:weight]["date(3i)"].to_i, params[:weight]["date(4i)"].to_i, params[:weight]["date(5i)"].to_i) : weight.date = Time.now
		weight.user = session[:person]
		weight.weight = params[:weight][:weight]
		weight.note = params[:weight][:note]
		if params[:checkbox][:after_eating] == '1'
			weight.after_eating = 'y'
		else
			weight.after_eating =  'n'
		end
		weight.save
		
		Task::set_current_user(session[:person])
		@updated_tasks = @cage.update_weighing_tasks
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
      bat_note = BatNote.new
			bat_note.bat = @bat
			bat_note.text = params[:bat][:note]
			bat_note.date = Time.now
			bat_note.user = session[:person]
			bat_note.save
      render :partial => 'bats/display_bat_notes'
    end
	end

	def show_or_hide_vaccination_date
    if params[:bat]
      bat = Bat.find(params[:bat])
    else
      bat = nil
    end
		render :partial => 'form_vaccination', :locals=>{:bat=>bat, :show_vaccination_date_select=>params[:show_vaccination_date_select], 
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