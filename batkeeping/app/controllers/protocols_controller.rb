class ProtocolsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @protocol_pages, @protocols = paginate :protocols, :per_page => 10
  end

  def show
    @protocol = Protocol.find(params[:id])
  end

  def new
    @protocol = Protocol.new
  end

  def create
    @protocol = Protocol.new(params[:protocol])
    if @protocol.save
      flash[:notice] = 'Protocol was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @protocol = Protocol.find(params[:id])
  end

  def update
    @protocol = Protocol.find(params[:id])
    if @protocol.update_attributes(params[:protocol])
      flash[:notice] = 'Protocol was successfully updated.'
      redirect_to :action => 'show', :id => @protocol
    else
      render :action => 'edit'
    end
  end

  def destroy
    Protocol.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
