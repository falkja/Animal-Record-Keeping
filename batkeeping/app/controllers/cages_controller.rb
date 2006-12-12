class CagesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @cage_pages, @cages = paginate :cages, :conditions => "date_destroyed is null", :order => 'name', :per_page => 10
    @list_all = false
  end

  def list_all
    @cage_pages, @cages = paginate :cages, :order => 'name', :per_page => 10
    @list_all = true
    render :action => 'list'
  end
  
  def show
    @cage = Cage.find(params[:id])
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
      redirect_to :action => 'list'
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
    if @cage.update_attributes(params[:cage])
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
	redirect_to :action => 'list'
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

  # needs to save the weights from the weigh page and save them for each data row
  def submit_weights
      
    #enter weights  
	@cage = Cage.find(params[:id])
	bat_ids = params[:weight].keys #params[:weight] is a hash whose keys are the bat ids
	@bats = Bat.find(bat_ids)
	for bat in @bats	        
		weight = Weight.new
		weight.bat = bat
		weight.date = Time.now
		weight.user = session[:person]
		weight.weight = params[:weight][bat.id.to_s] #The hash key is actually a string, so we need to convert the id to a string
        weight.note = params[:note][bat.id.to_s]
		weight.save
	end
    
    #now perform cage changes, if needed
	for bat in @bats	        
        Bat::set_user_and_comment(session[:person], params[:cage_change_note][bat.id.to_s]) #This must come before we mess with the list of bats for a cage. The moment we mess with the list, the cage and bat variables are updated.      
        bat.cage = Cage.find(params[:bat_cage][bat.id.to_s])
        bat.save
    end
    
  end

end
