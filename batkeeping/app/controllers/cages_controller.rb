class CagesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @cage_pages, @cages = paginate :cages, :per_page => 10
  end

  def list_all
    @cage_pages, @cages = paginate :cages, :per_page => 10
  end
  
  def show
    @cage = Cage.find(params[:id])
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
	@deactivating = true
  end
  
  def reactivate
	@cage = Cage.find(params[:id])
	@cage.date_destroyed = nil
	@cage.save
	redirect_to :action => 'list'
  end
end
