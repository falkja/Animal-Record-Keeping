class WeightsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @weight_pages, @weights = paginate :weights, :per_page => 10
  end

  def show
    @weight = Weight.find(params[:id])
  end

  def new
    @weight = Weight.new
  end

  def create
    @weight = Weight.new(params[:weight])
    if @weight.save
      flash[:notice] = 'Weight was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @weight = Weight.find(params[:id])
  end

  def update
    @weight = Weight.find(params[:id])
    if @weight.update_attributes(params[:weight])
      flash[:notice] = 'Weight was successfully updated.'
      redirect_to :action => 'show', :id => @weight
    else
      render :action => 'edit'
    end
  end

  def destroy
    Weight.find(params[:id]).destroy
		bat = Bat.find(params[:bat])
		render :partial => 'bats/display_weights', :locals => {:bat => bat}
  end
end
