class CageInHistoriesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @cage_in_history_pages, @cage_in_histories = paginate :cage_in_histories, :per_page => 10
  end

  def show
    @cage_in_history = CageInHistory.find(params[:id])
  end

  def new
    @cage_in_history = CageInHistory.new
  end

  def create
    @cage_in_history = CageInHistory.new(params[:cage_in_history])
    if @cage_in_history.save
      flash[:notice] = 'CageInHistory was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @cage_in_history = CageInHistory.find(params[:id])
  end

  def update
    @cage_in_history = CageInHistory.find(params[:id])
    if @cage_in_history.update_attributes(params[:cage_in_history])
      flash[:notice] = 'CageInHistory was successfully updated.'
      redirect_to :action => 'show', :id => @cage_in_history
    else
      render :action => 'edit'
    end
  end

  def destroy
    CageInHistory.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
