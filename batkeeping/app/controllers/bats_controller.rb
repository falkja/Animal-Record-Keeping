class BatsController < ApplicationController
  require "gruff"
  def index
redirect_to :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
		 :redirect_to => { :action => :list }

  def list
    @bats = Bat.find(:all, :order => 'band', :conditions => "leave_date is null")
    @list_all = false
    @div_id = 'bats_div'
  end
  
  def list_all
    @bats = Bat.find(:all, :order => 'band')
    @list_all = true
    @div_id = 'bats_div'
    render :action => 'list'
  end
  
  def list_by_cage
	@bats = Bat.find(params[:ids], :order => 'cage_id, band')
  @list_all = false
    @div_id = params[:div]
    @weighing = params[:weighing]
	render_partial 'bat_list', @bats
  end
  
  def list_all_by_cage
	@bats = Bat.find(params[:ids], :order => 'cage_id, band')
  @list_all = true
    @div_id = params[:div]
    @weighing = params[:weighing]
	render_partial 'bat_list', @bats
  end
  
  def list_by_band
	@bats = Bat.find(params[:ids], :order => 'band, cage_id')
  @list_all = false
    @div_id = params[:div]
    @weighing = params[:weighing]
	render_partial 'bat_list', @bats
  end
  
  def list_all_by_band
	@bats = Bat.find(params[:ids], :order => 'band, cage_id')
	@list_all = true
    @div_id = params[:div]
    @weighing = params[:weighing]
	render_partial 'bat_list', @bats
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
	
  for medical_problem in @bat.medical_problems
    medical_problem.date_closed = Time.now
    for proposed_treatment in medical_problem.proposed_treatments
      proposed_treatment.date_closed = Time.now
      proposed_treatment.save
    end
    medical_problem.save
  end
  
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
	@all_cages = Cage.find(:all)
	@cages = Array.new
	for cage in @all_cages
	  if cage.bats.count > 0
		@cages << cage
	  end
	end
  end

  #choose bats to move from cage
  def cage_change
	@cage = Cage.find(params[:id])
	@bats = @cage.bats
  	@cages = Cage.find(:all, :conditions => "date_destroyed is null and id != " + @cage.id.to_s, :order => "name")
  end

  #move a set of bats from one cage to another
  def move
	@bats = Bat.find(params[:bat][:id], :order => 'band')
	@cage = Cage.find(params[:cage][:id])
	Bat::set_user_and_comment(session[:person], params[:move]['note']) #This must come before we mess with the list of bats for a cage. The moment we mess with the list, the cage and bat variables are updated. 
	@cage.bats << @bats
	@cage.bats = @cage.bats.uniq #no duplicates
  flash[:notice] = 'Moved bats '
  @bats.each {|bat| flash[:notice] = flash[:notice] + bat.band + ' ' }
  flash[:notice] = flash[:notice] + ' to ' + @cage.name
  redirect_to :controller => 'cages', :action => 'list'
  end

  def choose_bat_to_weigh
    @bats = Bat.find(:all, :conditions => "leave_date is null", :order => "band")
  end
  
  def weigh_bat
    @bat = Bat.find(params[:id])
    @cages = Cage.find(:all, :conditions => "date_destroyed is null", :order => "name" )
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
		weight.save
    
    @cage.update_weighing_tasks
    
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
end
