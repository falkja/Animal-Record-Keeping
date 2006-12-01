class ProtocolEndHistoriesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @protocol_end_history_pages, @protocol_end_histories = paginate :protocol_end_histories, :per_page => 10
  end

  def show
    @protocol_end_history = ProtocolEndHistory.find(params[:id])
  end

  def new
    @protocol_end_history = ProtocolEndHistory.new
  end

  def create
    @protocol_end_history = ProtocolEndHistory.new(params[:protocol_end_history])
    if @protocol_end_history.save
      flash[:notice] = 'ProtocolEndHistory was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @protocol_end_history = ProtocolEndHistory.find(params[:id])
  end

  def update
    @protocol_end_history = ProtocolEndHistory.find(params[:id])
    if @protocol_end_history.update_attributes(params[:protocol_end_history])
      flash[:notice] = 'ProtocolEndHistory was successfully updated.'
      redirect_to :action => 'show', :id => @protocol_end_history
    else
      render :action => 'edit'
    end
  end

  def destroy
    ProtocolEndHistory.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
