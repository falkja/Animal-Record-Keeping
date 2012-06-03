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
    if params[:bats]
      @bats = Bat.find(params[:bats])
    else
      @bats = Bat.active
    end
  end
  
  def list_all
    @bats = Bat.find(:all, :order => 'band')
    @show_leave_date_and_reason = true
    render :action => 'list'
  end

	def list_deactivated
		@bats = Bat.not_active
		@show_leave_date_and_reason = true
		render :action => 'list'
	end

  def change_bats_list
    if params[:cage] && params[:cage][:id] != ""
      bats = Cage.find(params[:cage][:id]).bats
    elsif params[:protocol] && params[:protocol][:id] != ""
      bats = Protocol.find(params[:protocol][:id]).bats
    elsif params[:room] && params[:room][:id] != ""
      bats = Room.find(params[:room][:id]).bats
    elsif params[:species] && params[:species][:id] != ""
      bats = Species.find(params[:species][:id]).bats.active
    elsif params[:user] && params[:user][:id] != ""
      bats = User.find(params[:user][:id]).bats
    elsif params[:option]
      if params[:option]=='med'
        bats = Bat.sick
      elsif params[:option]=='flight_exempt'
        bats = Bat.exempt_from_flight
      elsif params[:option]=='non_flight_exempt'
        bats = Bat.not_exempt_from_flight
      elsif params[:option]=='not_weighed'
        bats = Bat.not_weighed(Bat.active,Date.today)
      elsif params[:option]=='not_flown'
        bats = Bat.not_flown(Bat.active,3)
      elsif params[:option]=='current'
        bats = Bat.active
      elsif params[:option]=='deactivated'
        bats = Bat.not_active
      elsif params[:option]=='all'
        bats = Bat.all
      elsif params[:option]=='my'
        bats = User.find(session[:person]).bats
      end
    end
    render_bat_list(bats)
  end

	def sort_by_species
		bat_list = Bat.find(params[:ids])
		bat_list = bat_list.sort_by{|bat| [bat.species.name, bat.band.downcase]}
    render_bat_list(bat_list)
	end

  def sort_by_deactivation_date
		bat_list = Bat.find(params[:ids], :order => 'leave_date')
    render_bat_list(bat_list)
	end
	
	def sort_by_gender
		bat_list = Bat.find(params[:ids], :order => 'gender, band')
    render_bat_list(bat_list)
	end
	
	def sort_by_weight
		bat_list = Bat.find(params[:ids])
		bat_list = bat_list.sort_by{|bat| [bat.weights.recent_never_nil.weight, bat.band.downcase]}
		render_bat_list(bat_list)
	end

	def sort_by_weigh_date
		bat_list = Bat.find(params[:ids])
		bat_list = bat_list.sort_by{|bat| [bat.weights.recent_never_nil.date.to_f, bat.band.downcase]}
		render_bat_list(bat_list)
	end
  
  def sort_by_last_flown
		bat_list = Bat.find(params[:ids])
		bat_list = bat_list.sort_by{|bat| [bat.flights.empty? ? Date.new : bat.flights[-1].date, bat.band.downcase]}
		render_bat_list(bat_list)
	end

  def sort_by_sx
		bat_list = Bat.find(params[:ids], :order => 'band')
		bat_list = bat_list.sort_by{|bat| [-bat.surgeries.length, bat.band.downcase]}
		render_bat_list(bat_list)
	end

  def sort_by_protocols
		bat_list = Bat.find(params[:ids], :order => 'band')
		bat_list = bat_list.sort_by{|bat| [bat.protocols.length, bat.band.downcase]}
		render_bat_list(bat_list)
	end
	
  def sort_by_band
    bat_list = Bat.find(params[:ids], :order => 'band')
    render_bat_list(bat_list)
  end
  
  def sort_by_cage
    bat_list = Bat.find(params[:ids], :order => 'band')
		bat_list = bat_list.sort_by{|bat| bat.cage_never_nil.name.downcase}
    render_bat_list(bat_list)
  end
	
	def sort_by_collected
    bat_list = Bat.find(params[:ids], :order => 'collection_date, band')
    render_bat_list(bat_list)
	end

  def sort_by_med
    bat_list = Bat.find(params[:ids], :order => 'band')
    bat_list = bat_list.sort_by{|bat| [-bat.medical_problems.current.length,
        bat.cage.name.downcase, bat.band.downcase]}
    render_bat_list(bat_list)
  end

  def render_bat_list(bat_list)
    render :partial => 'bat_list', :locals => {
      :bat_list => bat_list, :div_id => params[:div_id],
      :show_leave_date_and_reason => params[:show_leave_date_and_reason],
      :show_weigh_link => params[:show_weigh_link]}
  end
  
  def show
    @bat = Bat.find(params[:id])
    @cihs = @bat.cage_in_histories
    
    #for bat changes:
    @bat_changes = BatChange.find(:all, 
      :conditions => "bat_id = #{@bat.id}", :order => 'date desc')
  end

	def new
		@bat = Bat.new
		instance_vars_for_new_bat
	end

	def instance_vars_for_new_bat
		@cages = Cage.active
		@species = Species.find(:all)
		@protocols = Protocol.current
		@reactivating = false
		@deactivating = false
		@creating = true
		if @cages.length == 0
			flash[:notice] = 'New bats need a cage.  Create a cage before creating a bat.'
			redirect_to :controller => 'cages', :action => :new
		elsif @species.length == 0
			flash[:notice] = 'New bats need a species.  Create a species before creating a bat.'
			redirect_to :controller => 'species', :action => :new
		elsif @protocols.length == 0
			flash[:notice] = 'New bats need a current protocol.  Create a current protocol before creating a bat.'
			redirect_to :controller => :protocols, :action => :new
		end
		@weight = Weight.new
    @action = "create"
	end

  def grab_protocols
    protocol_ids = params["protocol_id"]
    protocols=Array.new
    if protocol_ids
      protocol_ids.each {|key,value| value !="0" ? protocols << Protocol.find(key) : ''}
    end
    return protocols
  end

  def create
    @bat = Bat.new(params[:bat])
	
    protocols = grab_protocols

    #check if protocols over the allowed limit before saving the bat
    for p_added in protocols
      sp = Species.find(@bat.species)
      if Bat.on_species(p_added.all_past_bats,sp).length >= p_added.allowed_bats_by_species(sp).number
        over_allowed = true
      end
    end

    if protocols.length == 0
      flash[:notice] = 'Select a protocol.'
      instance_vars_for_new_bat
      render :action => :new
    elsif over_allowed
      flash[:notice] = 'Over allowed limit on protocol.'
      instance_vars_for_new_bat
      render :action => :new
    elsif !params[:bat][:cage_id]
      flash[:notice] = 'Select a cage.'
      instance_vars_for_new_bat
      render :action => :new
    elsif ((params[:bat][:cage_id] == '0') && (params[:move][:note] == ''))
      flash[:notice] = 'Enter leave reason.'
      instance_vars_for_new_bat
      render :action => :new
    elsif params[:surgery] && params[:surgery_type] == nil
      flash[:notice] = 'Need to enter a surgery type'
      instance_vars_for_new_bat
      render :action => :new
    elsif params[:surgery_type] && (SurgeryType.find(params[:surgery_type][:id]).protocols & 
        bat.protocols).empty?
      flash[:notice] = 'Add surgery type to the protocol of this bat'
      instance_vars_for_new_bat
      render :action => :new
    else
      params[:bat][:cage_id] != '0' ? @bat.leave_date = nil : ''

      Bat::set_user_and_comment(User.find(session[:person]), 'new bat') #Do this before saving!
      if @bat.save
				
        if params[:weight][:weight] != ''
          save_weight
        end
			
        @bat.save_protocols(protocols,Time.now,User.find(session[:person]))
        
        if params[:surgery]
          save_surgery
        end

        if @bat.cage_id == 0
          new_cage=nil
          @bat.cage_id = nil
          @bat.leave_reason = params[:move][:note]
          @bat.save
        else
          new_cage=Cage.find(params[:bat][:cage_id])

          #census stuff
          census = Census.find_or_create_by_date_and_room_id(Date.today, new_cage.room)
          census.tally(1, Date.today, new_cage.room)
          census.bats_added ? census.bats_added = census.bats_added + @bat.band + ' ' : census.bats_added = @bat.band + ' '
          census.save
        end

        flash[:notice] = 'Bat was successfully created.'
			
        if new_cage
          @bats = Array.new
          @bats << @bat
          redirect_to :action => 'move', :bats => @bats, :new_cage => new_cage, :old_cage => nil, :note => 'new bat'
        else
          redirect_to :action => :list_deactivated
        end
      else
        instance_vars_for_new_bat
        render :action => :new
      end
    end
  end

  def adding_deactivated_bat
    params[:bat][:cage_id]== '0' ? @deactivated_bat = true : @deactivated_bat = false
    render :partial => 'adding_deactivated_bat'
  end

  def edit
    @current_user = User.find(session[:person])
    @cages = Cage.active
    @bat = Bat.find(params[:id])
    @species = Species.find(:all)
    @protocols = Protocol.current
    @deactivating = false
    @action = "update"
  end

  def update
    if (params[:bat][:cage_id] == '') && !@deactivating && !@reactivating
      flash[:notice] = 'Need to select a cage.'
      redirect_to :back
      return
    elsif params[:surgery] && params[:surgery_type] == nil
      flash[:notice] = 'Select a surgery type'
      redirect_to :back
      return
    elsif params[:surgery_type] && (SurgeryType.find(params[:surgery_type][:id]).protocols & 
        Bat.find(params[:id]).protocols).empty?
      flash[:notice] = 'Add surgery type to the protocol of this bat'
      redirect_to :back
      return
    end

    @bat = Bat.find(params[:id])

    if !@deactivating
      protocols = grab_protocols

      #check if protocols over the allowed limit before saving the bat
      for p_added in (protocols - @bat.protocols)
        if !p_added.check_allowed_bats(Array.new(1,@bat))
          over_allowed = true
        end
      end

    else
      protocols=Array.new
    end
    
    if !@deactivating
      if protocols.length == 0
        flash[:notice] = 'Need to select a protocol'
        redirect_to :back
        return
      elsif over_allowed
        flash[:notice] = 'Over allowed limit on protocol.'
        redirect_to :back
        return
      end
    end

    if params[:bat][:surgery_type] == '' and params[:bat]["surgery_time(1i)"] != nil
      flash[:notice] = 'Need to enter a surgery type'
      redirect_to :back
      return
    end

    if @reactivating
      note = 'reactivated'
      @cage = nil
    elsif (params[:move] != nil)
      note = params[:move][:note]
    else
      note = ''
    end

    Bat::set_user_and_comment(User.find(session[:person]), note) #Do this before saving!

    old_band_name = @bat.band

    if @bat.update_attributes(params[:bat])
      if @bat.band != old_band_name
        bat_change = BatChange.new
        bat_change.date = Date.today
        bat_change.bat = @bat
        bat_change.old_band_name = old_band_name
        bat_change.new_band_name = @bat.band
        bat_change.user = User.find(session[:person])
        bat_change.save
      end

      @bat.save_protocols(protocols,Time.now,User.find(session[:person]))
      
      if params[:surgery]
        save_surgery
      end

      flash[:notice] = 'Bat was successfully updated.'
      if params[:redirectme] == 'list'
        redirect_to :action => :list
      elsif params[:redirectme] == 'show'
        redirect_to :action => :show, :id => @bat
      elsif params[:redirectme] == 'move'
        @bats = Array.new
        @bats << @bat
        redirect_to :action => 'move', :bats => @bats, :new_cage => @bat.cage, :old_cage => @cage, :note => note
      else
        redirect_to :action => 'show', :id => @bat
      end
    else
      @action = "update"
      render :action => 'edit'
    end
  end

  def destroy
    Bat.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def deactivate
    @cages = Cage.active
    @bat = Bat.find(params[:id])
    @species = Species.find(:all)
    @protocols = Protocol.current
    @deactivating = true
    @action = "deactivate_bat"
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
      medical_problem.reason_closed = params[:bat][:leave_reason]
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
    @cages = Cage.active
    @protocols = Protocol.current
    @reactivating = true
    @action = "reactivate_bat"
  end
  
  #because now we need to choose a cage for the zombie bat!
  def reactivate_bat
    if params[:bat][:cage_id] == nil
      flash[:notice] = "Reactivation failed.  Choose a cage for your reactivated bat."
      redirect_to :back
    elsif params["protocol_id"] == nil
      flash[:notice] = "Reactivation failed.  Choose a protocol for your reactivated bat."
      redirect_to :back
    else
      Bat::set_user_and_comment(User.find(session[:person]), 'reactivated') #Do this before saving!
      @bat = Bat.find(params[:id])
      @bat.leave_date = nil
      @bat.leave_reason = nil
      @bat.cage = Cage.find(params[:bat][:cage_id])
      @bat.save
	
      #census stuff
      census = Census.find_or_create_by_date_and_room_id(Date.today, @bat.cage.room)
      census.tally(1, Date.today, @bat.cage.room)
      census.bats_added ? census.bats_added = census.bats_added + @bat.band + ' ' : census.bats_added = @bat.band + ' '
      census.save

      @reactivating = true
      update #only used to add the protocols
    end
  end

  #choose a cage to move bats from
  def move_bats
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
    render :partial => 'choose_bats_to_move',
      :locals => {:cage => cage, :bats => bats, :selected_bats => selected_bats}
  end

	def add_bat_to_move_list
    cage = Cage.find(params[:id])
		bats = Array.new(cage.bats)
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
		bats = Array.new(cage.bats)
		bat_to_remove = Bat.find(params[:bat_to_remove])
		selected_bats = Bat.find(params[:selected_bats])
    selected_bats = selected_bats - Array.new(1,bat_to_remove)
    bats = bats - selected_bats
		render :partial => 'choose_bats_to_move',
      :locals => {:cage => cage, :bats => bats, :selected_bats => selected_bats}
	end

  def choose_destination
    bats = Bat.find(params[:bats], :order => 'band')
    cage = Cage.find(params[:id])
    cages = Cage.active - Array.new(1,cage)
    render :partial => 'choose_destination_cage',
      :locals => {:old_cage => cage, :bats => bats, :cages => cages}
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

    Bat::set_user_and_comment(User.find(session[:person]),@note) #This must come before we mess with the list of bats for a cage. The moment we mess with the list, the cage and bat variables are updated. 
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
    
    MyMailer.email_after_bats_moved(@bats,@old_cage,@new_cage)
		
  end
	
  def single_bat_to_move
    bat = Bat.find(params[:id])
    @bats = Array.new
    @bats << bat
    @cage = bat.cage
    @cages = Cage.active - Array.new(1,@cage)
  end

  def move_bats_from_cage
    @cage = Cage.find(params[:id])
  end
  
	def manage_cage_tasks_after_move		
		render :partial=> 'manage_cage_tasks_after_move', :locals=>{:step=>params[:step].to_i,:old_cage=>Cage.find(params[:old_cage]), :new_cage => Cage.find(params[:new_cage])}
	end

	def manage_cage_tasks_after_deactivate_or_reactivate
		render :partial=> 'manage_cage_tasks_after_deactivate_or_reactivate', :locals=>{:step=>params[:step].to_i,:cage=>Cage.find(params[:cage]), :deactivating => params[:deactivating]}
	end

  def choose_bat_to_weigh
  	if params[:bats]
      @bats = Bat.find(params[:bats])
    else
      @bats = Bat.active
    end
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
      
      if params[:weight]["date(1i)"]
        date = Date.civil(params[:weight]["date(1i)"].to_i,params[:weight]["date(2i)"].to_i, params[:weight]["date(3i)"].to_i)
      else
        date = Date.today
      end
      #saving the flight if there is one
      if params[:checkbox][:bat_flown] == '1'
        save_flight(date)
      #removing the flight if the user deselected it and we're not entering a weight for a different day
      elsif @bat.flights.find(:first,:conditions => {:date => date}) 
        @bat.flights.find(:first,:conditions => {:date => date}).destroy
      end
      if params[:redirectme]
        redirect_to :controller => 'cages', :action => 'weigh_cage', :id => params[:redirectme]
      end
    end
  end
	def save_flight(date)
    
		if !@bat.flown_on(date)
			flight=Flight.new
			
			flight.bat = @bat
			flight.user = User.find(session[:person])
			
			params[:weight]["date(1i)"] ? flight.date = Date.civil(params[:weight]["date(1i)"].to_i,params[:weight]["date(2i)"].to_i, params[:weight]["date(3i)"].to_i) : flight.date = Date.today
			
			flight.note = params[:weight][:note]
			
			flight.save
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
		weight.user = User.find(session[:person])
		weight.weight = params[:weight][:weight]
		weight.note = params[:weight][:note]
		if params[:checkbox][:after_eating] == '1'
			weight.after_eating = 'y'
		else
			weight.after_eating =  'n'
		end
		weight.save
	end
	
  def graph_weights
    bat = Bat.find(params[:id])
    weight_classes = bat.weights
    weights_after_eating = Array.new
    weights_before_eating = Array.new
    dates = Hash.new
    dates_reduced = Hash.new
    n = 0
    weight_classes.reverse_each {
      |weight| 
      if (weight.after_eating == 'y') 
				weights_after_eating << weight.weight; weights_before_eating << nil
			else 
				weights_before_eating << weight.weight; weights_after_eating << nil
			end 
      dates[n] = weight.date.strftime('%m-%d-%y');
      n = n + 1;
    }
    
    spacing = (dates.length/6.0).ceil
    
    0.step( dates.length-1, spacing) {|i|  dates_reduced[i] = dates[i] }
    
    g = Gruff::Line.new(800)
    
    g.title = bat.band + " Weights"
    bat.species.lower_weight_limit ? g.baseline_value = bat.species.lower_weight_limit : ''
    g.data('After Eating', weights_after_eating)
    g.data('Before Eating', weights_before_eating)
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
			bat_note.user = User.find(session[:person])
			bat_note.save
      render :partial => 'bats/display_bat_notes'
    end
	end

	def show_or_hide_vaccination_date
    if params[:bat] and params[:bat] != ''
      bat = Bat.find(params[:bat])
    else
      bat = nil
    end
		render :partial => 'form_vaccination', :locals=>{:bat=>bat, :show_vaccination_date_select=>params[:show_vaccination_date_select], 
      :reactivating=>params[:reactivating], :show_submit_button => params[:show_submit_button]}
	end
	
	def clear_vaccination_date
		bat = Bat.find(params[:bat])
		bat.vaccination_date = nil
		bat.save
		render :partial => 'form_vaccination', :locals=>{:bat=>bat, :show_vaccination_date_select=>false, 
      :reactivating=>params[:reactivating], :show_submit_button => params[:show_submit_button]}
	end

  def remote_save_vaccination
    bat = Bat.find(params[:id])
    bat.vaccination_date =
      Date.civil(params[:bat]["vaccination_date(1i)"].to_i,
      params[:bat]["vaccination_date(2i)"].to_i,
      params[:bat]["vaccination_date(3i)"].to_i)
    bat.save
    render :partial => 'form_vaccination', :locals=>{:bat=>bat, :show_vaccination_date_select=>false,
      :reactivating=>params[:reactivating], :show_submit_button => params[:show_submit_button]}
  end

  def show_add_surgery_type_form
    if params[:bat] and params[:bat] != ''
      bat = Bat.find(params[:bat])
    else
      bat = nil
    end
    
    render :partial => 'surgery_type_form', :locals => {:bat => bat, 
        :show_submit_button => params[:show_submit_button], 
        :show_surgery_type_form => !params[:show_surgery_type_form]} 
  end
  
  def delete_surgery_type
    if params[:bat] and params[:bat] != ''
      bat = Bat.find(params[:bat])
    else
      bat = nil
    end
    
    sg_type = SurgeryType.find(params[:id])
    if !sg_type.surgeries.empty? || !sg_type.protocols.empty?
      flash.now[:surgery_notice]='Surgery type has surgeries or protocols, cannot delete'
    else
      sg_type.destroy
      flash.now[:surgery_notice]='Surgery Type Removed'
    end
    
    render :partial => 'form_surgery', :locals=>{:bat=>bat,
      :show_submit_button => params[:show_submit_button],
      :show_surgery_form => true}
  end
  
  def new_surgery_type
    sg_type = SurgeryType.new
    sg_type.name = params[:name]
    sg_type.save
    
    if params[:bat] and params[:bat] != ''
      bat = Bat.find(params[:bat])
    else
      bat = nil
    end
    
    render :partial => 'form_surgery', :locals=>{:bat=>bat,
      :show_submit_button => params[:show_submit_button],
      :show_surgery_form => true}
  end
  
  def show_or_hide_surgery_form
    if params[:bat] and params[:bat] != ''
      bat = Bat.find(params[:bat])
    else
      bat = nil
    end
		render :partial => 'form_surgery', :locals=>{:bat=>bat,
      :show_submit_button => params[:show_submit_button],
      :show_surgery_form => params[:show_surgery_form]}
	end

	def remote_save_surgery
    bat = Bat.find(params[:bat])
    if params[:surgery_type] == nil
      flash.now[:surgery_notice]='Select a surgery type'
      render :partial => 'form_surgery', :locals=>{:bat=>bat,
      :show_surgery_form => true, 
      :show_submit_button => params[:show_submit_button]}
    elsif (SurgeryType.find(params[:surgery_type][:id]).protocols & 
      bat.protocols).empty?
      flash.now[:surgery_notice]='Add surgery type to the protocol of this bat'
      render :partial => 'form_surgery', :locals=>{:bat=>bat,
      :show_surgery_form => true, 
      :show_submit_button => params[:show_submit_button]}
    else
      surgery = Surgery.new
      surgery.bat = bat
      surgery.surgery_type = SurgeryType.find(params[:surgery_type][:id])
      surgery.time =
        DateTime.civil(params[:surgery]["time(1i)"].to_i,
        params[:surgery]["time(2i)"].to_i,
        params[:surgery]["time(3i)"].to_i,
        params[:surgery]["time(4i)"].to_i,
        params[:surgery]["time(5i)"].to_i)
      surgery.note = params[:surgery][:note]
      surgery.user = User.find(session[:person])
      surgery.protocols = surgery.surgery_type.protocols & bat.protocols
      surgery.save
      flash.now[:surgery_notice]='Surgery saved'
      render :partial => 'form_surgery', :locals=>{:bat=>bat, :show_surgery_form => false,
        :show_submit_button => params[:show_submit_button]}
    end
  end
  
  #called from create and update
  def save_surgery
    surgery = Surgery.new
    surgery.bat = @bat
    surgery.surgery_type = SurgeryType.find(params[:surgery_type][:id])
    surgery.time =
      DateTime.civil(params[:surgery]["time(1i)"].to_i,
      params[:surgery]["time(2i)"].to_i,
      params[:surgery]["time(3i)"].to_i,
      params[:surgery]["time(4i)"].to_i,
      params[:surgery]["time(5i)"].to_i)
    surgery.note = params[:surgery][:note]
    surgery.user = User.find(session[:person])
    surgery.protocols = surgery.surgery_type.protocols & @bat.protocols
    surgery.save
  end
  
  def clear_surgery
		if params[:bat] and params[:bat] != ''
      bat = Bat.find(params[:bat])
    else
      bat = nil
    end
    surgery = Surgery.find(params[:id])
    bat_change = BatChange.find(:first, :conditions=>{:surgery_id=>surgery})
		surgery.destroy
    bat_change.destroy
    flash.now[:surgery_notice]='Surgery deleted'
		render :partial => 'form_surgery', :locals=>{:bat=>bat,
      :show_submit_button => params[:show_submit_button], :show_surgery_form => false}
	end

  def remote_save_protocol
		@bat = Bat.find(params[:bat])
		
		protocols = grab_protocols

    #check if protocols over the allowed limit before saving
    for p_added in (protocols - @bat.protocols)
      if !p_added.check_allowed_bats(Array.new(1,@bat))
        over_allowed = true
      end
    end

		if protocols.length == 0
      flash.now[:prot_notice] = 'Bat must always have a protocol'
    elsif over_allowed
      flash.now[:prot_notice] = 'Over the allowed bats limit on a protocol'
    else
      protocols = protocols.sort_by{|p| p.number}
      unless protocols == @bat.protocols
        @bat.save_protocols(protocols,Time.now,User.find(session[:person]))
        if (@bat.protocols - protocols).length == 0
          flash.now[:prot_notice] = 'Protocols saved'
        end
      else
        flash.now[:prot_notice] = 'Protocols did not change'
      end
    end
		render :partial => 'protocols/choose_protocols', :locals => {:protocols => Protocol.current, :bat => @bat}
	end
  
  def choose_protocols
    @bat = Bat.find(params[:id])
  end
  
  def search
    @bats = Bat.search(params[:search])
    @show_leave_date_and_reason = true
    render :action => 'list'
  end

end