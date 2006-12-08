class BatsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @bat_pages, @bats = paginate :bats, :order => 'cage_id, band', :per_page => 10
  end
  
  def list_all
	@bat_pages, @bats = paginate :bats, :order => 'cage_id, band', :per_page => 10
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
    if @bat.save
      flash[:notice] = 'Bat was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @current_user = session[:person]  
    @cages = Cage.find_all
	@bat = Bat.find(params[:id])
	@deactivating = false
  end

  def update
    @bat = Bat.find(params[:id])
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
	@cages = Cage.find_all
	@bat = Bat.find(params[:id])
	@deactivating = true
  end
  
  def reactivate
	@bat = Bat.find(params[:id])
	@bat.leave_date = nil
	@bat.leave_reason = nil
	@bat.save
	redirect_to :action => 'list'
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
  @cage = Cage.find(params[:cage][:id])
  @bats = @cage.bats
  @cages = Cage.find(:all, :conditions => "date_destroyed is null and id != " + @cage.id.to_s, :order => "name")
  end

  #move a set of bats from one cage to another
  def move
    @bats = Bat.find(params[:bat][:id], :order => 'band')
    @cage = Cage.find(params[:cage][:id], :order => 'name')
    @cage.bats << @bats
    @cage.bats = @cage.bats.uniq
    @current_user = session[:person]
  end
end
