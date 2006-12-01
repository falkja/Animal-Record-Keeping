class ProtocolStartHistoriesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @protocol_start_history_pages, @protocol_start_histories = paginate :protocol_start_histories, :per_page => 10
  end

  def show
    @protocol_start_history = ProtocolStartHistory.find(params[:id])
  end

  def new
    @protocol_start_history = ProtocolStartHistory.new
  end

  def create
    @protocol_start_history = ProtocolStartHistory.new(params[:protocol_start_history])
    if @protocol_start_history.save
      flash[:notice] = 'ProtocolStartHistory was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @protocol_start_history = ProtocolStartHistory.find(params[:id])
  end

  def update
    @protocol_start_history = ProtocolStartHistory.find(params[:id])
    if @protocol_start_history.update_attributes(params[:protocol_start_history])
      flash[:notice] = 'ProtocolStartHistory was successfully updated.'
      redirect_to :action => 'show', :id => @protocol_start_history
    else
      render :action => 'edit'
    end
  end

  def destroy
    ProtocolStartHistory.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
