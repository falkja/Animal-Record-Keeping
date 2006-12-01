class ProtocolHistoriesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @protocol_history_pages, @protocol_histories = paginate :protocol_histories, :per_page => 10
  end

  def show
    @protocol_history = ProtocolHistory.find(params[:id])
  end

  def new
    @protocol_history = ProtocolHistory.new
  end

  def create
    @protocol_history = ProtocolHistory.new(params[:protocol_history])
    if @protocol_history.save
      flash[:notice] = 'ProtocolHistory was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @protocol_history = ProtocolHistory.find(params[:id])
  end

  def update
    @protocol_history = ProtocolHistory.find(params[:id])
    if @protocol_history.update_attributes(params[:protocol_history])
      flash[:notice] = 'ProtocolHistory was successfully updated.'
      redirect_to :action => 'show', :id => @protocol_history
    else
      render :action => 'edit'
    end
  end

  def destroy
    ProtocolHistory.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
