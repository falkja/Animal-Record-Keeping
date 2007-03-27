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
    @list_all = false
  end
  
  def list_all
    @bats = Bat.find(:all, :order => 'band')
    @list_all = true
    render :action => 'list'
  end

	def sort_by_species
		bat_list = Bat.find(params[:ids], :order => 'species, band')
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
	cihs = @bat.cage_in_histories
	@cohs = Array.new
	for cih in cihs
		coh = cih.cage_out_history
		coh ? @cohs << coh : ''
	end        
  end

  def new
	@cages = Cage.find(:all, :conditions => "date_destroyed is null", :order => "name")
	@bat = Bat.new
	@deactivating = false
  end

  def create
	@bat = Bat.new(params[:bat])
	@bat.leave_date = nil
    Bat::set_user_and_comment(session[:person], params[:move]['note']) #Do this before saving!
	if @bat.save
	  flash[:notice] = 'Bat was successfully created.'
	  redirect_to :action => 'list'
	else
	  render :action => 'new'
	end
  end

  def edit
	@current_user = session[:person]  
	@cages = Cage.find(:all, :conditions => "date_destroyed is null", :order => "name" )
	@bat = Bat.find(params[:id])
	@deactivating = false
  end

  def update
	@bat = Bat.find(params[:id])
    Bat::set_user_and_comment(session[:person], params[:move]['note']) #Do this before saving!
		
	if @bat.update_attributes(params[:bat])
	  if @deactivating
	    for medical_problem in @bat.medical_problems
		  medical_problem.date_closed = @bat.leave_date
		  medical_problem.save
		  for task in medical_problem.tasks.current
		    task.date_ended = @bat.leave_date
		    task.save
		  end
		end
	  end
	  flash[:notice] = 'Bat was successfully updated.'
	  if params[:redirectme] == 'list'
		redirect_to :action => 'list'
	  else
		redirect_to :action => 'show', :id => @bat
	  end
	else
	  render :action => 'edit'
	end
  end

  def destroy
	Bat.find(params[:id]).destroy
	redirect_to :action => 'list'
  end
  
  def deactivate
	@cages = Cage.find(:all, :conditions => "date_destroyed is null", :order => "name" )
	@bat = Bat.find(params[:id])
	@deactivating = true
  end
  
  #the simplest way to handle cage leave event is like this
  def deactivate_bat
	@bat = Bat.find(params[:id])
	params[:move]['note'] = params[:bat]['leave_reason']
	params[:bat]['cage_id'] = nil
	@deactivating = true
	update
  end
  
  def reactivate
    @bat = Bat.find(params[:id])
    @cages = Cage.find(:all, :conditions => "date_destroyed is null", :order => "name" )
    @reactivating = true
  end
  
  #because now we need to choose a cage for the zombie bat!
  def reactivate_bat
	@bat = Bat.find(params[:id])
	@bat.leave_date = nil
	@bat.leave_reason = nil
	@bat.save
	
  update
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
    @new_cage = Cage.find(params[:new_cage])
    @old_cage = Cage.find(params[:old_cage])
    @note = params[:move][:note]
    
    Bat::set_user_and_comment(session[:person], params[:move]['note']) #This must come before we mess with the list of bats for a cage. The moment we mess with the list, the cage and bat variables are updated. 
    @new_cage.bats << @bats
    @new_cage.bats = @new_cage.bats.uniq #no duplicates
  
    #when we finally get emails working uncomment the following
    #email = MyMailer.deliver_mail("falk.ben@gmail.com")
  end
	
	def manage_cage_tasks_after_move		
		render :partial=> 'manage_cage_tasks_after_move', :locals=>{:step=>params[:step].to_i,:old_cage=>Cage.find(params[:old_cage]), :new_cage => Cage.find(params[:new_cage])}
	end

  def choose_bat_to_weigh
    @bats = Bat.active
	@list_all = false
  end
  
  def weigh_bat
    @bat = Bat.find(params[:id])
    @cages = Cage.find(:all, :conditions => "date_destroyed is null", :order => "name" )
		@medical_tasks = Array.new
		for medical_problem in @bat.medical_problems
			for task in medical_problem.tasks
				@medical_tasks << task
			end
		end
  end
  
  def submit_weight
		@bat = Bat.find(params[:id])
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
    
    #now perform cage changes, if needed
		Bat::set_user_and_comment(session[:person], params[:cage_change_note][@bat.id.to_s]) #This must come before we mess with the list of bats for a cage. The moment we mess with the list, the cage and bat variables are updated.      
		@bat.cage = Cage.find(params[:bat_cage][@bat.id.to_s])
		@bat.save

		if params[:redirectme]
			redirect_to :controller => 'cages', :action => 'weigh_cage', :id => params[:redirectme]
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
    bat.species == "Eptesicus fuscus" ? g.baseline_value = 13 : ''
    bat.species == "Carollia perspicillata" ? g.baseline_value = 15 : ''
    bat.species == "Glossophaga soricina" ? g.baseline_value = 11 : ''
    bat.species == "Myotis septentrionalis" ? g.baseline_value = 7 : ''
    g.data(bat.band, weights)
    
    g.labels = dates_reduced #this is where we will need to put the dates
    
    send_data(g.to_blob, :disposition => 'inline', :type => 'image/png', :filename => bat.band + " weights.png")
  
  end
  
  def add_bat_note
	@bat = Bat.find(params[:id])
	if @bat.note != nil
	  @bat.note = @bat.note + '<tr><td>' + params[:bat][:note] + '</td><td>' + session[:person].initials + '</td><td>' + Time.now.strftime('%b %d, %Y') + '</td></tr>'
	else
	  @bat.note = '<tr><td>' + params[:bat][:note] + '</td><td>' + session[:person].initials + '</td><td>' + Time.now.strftime('%b %d, %Y') + '</td></tr>'
	end
	@bat.save
	render :partial => 'bats/display_bat_notes'
  end
end