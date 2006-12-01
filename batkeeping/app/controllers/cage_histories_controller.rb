class CageHistoriesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @cage_history_pages, @cage_histories = paginate :cage_histories, :per_page => 10
  end

  def show
    @cage_history = CageHistory.find(params[:id])
  end

  def new
    @cage_history = CageHistory.new
  end

  def create
    @cage_history = CageHistory.new(params[:cage_history])
    if @cage_history.save
      flash[:notice] = 'CageHistory was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @cage_history = CageHistory.find(params[:id])
  end

  def update
    @cage_history = CageHistory.find(params[:id])
    if @cage_history.update_attributes(params[:cage_history])
      flash[:notice] = 'CageHistory was successfully updated.'
      redirect_to :action => 'show', :id => @cage_history
    else
      render :action => 'edit'
    end
  end

  def destroy
    CageHistory.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
