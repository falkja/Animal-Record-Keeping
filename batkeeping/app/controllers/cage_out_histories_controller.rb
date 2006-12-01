class CageOutHistoriesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @cage_out_history_pages, @cage_out_histories = paginate :cage_out_histories, :per_page => 10
  end

  def show
    @cage_out_history = CageOutHistory.find(params[:id])
  end

  def new
    @cage_out_history = CageOutHistory.new
  end

  def create
    @cage_out_history = CageOutHistory.new(params[:cage_out_history])
    if @cage_out_history.save
      flash[:notice] = 'CageOutHistory was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @cage_out_history = CageOutHistory.find(params[:id])
  end

  def update
    @cage_out_history = CageOutHistory.find(params[:id])
    if @cage_out_history.update_attributes(params[:cage_out_history])
      flash[:notice] = 'CageOutHistory was successfully updated.'
      redirect_to :action => 'show', :id => @cage_out_history
    else
      render :action => 'edit'
    end
  end

  def destroy
    CageOutHistory.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
