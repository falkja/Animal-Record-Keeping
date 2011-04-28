class SpeciesController < ApplicationController
	def index
    list
    render :action => 'list'
  end
	
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @species = Species.find(:all)
  end

  def show
    @sp = Species.find(params[:id])
  end

  def new
    @sp = Species.new
  end

  def create
		@sp = Species.new(params[:sp])
		if @sp.save
			flash[:notice] = 'Species was successfully created.'
			redirect_to :action => 'list'
		else
			render :action => 'new'
		end
  end

  def edit
    @sp = Species.find(params[:id])
  end

  def update
		@sp = Species.find(params[:id])
		if @sp.update_attributes(params[:sp])
			flash[:notice] = 'Species was successfully updated.'
			redirect_to :action => 'show', :id => @sp
		else
			render :action => 'edit'
		end
  end

  def destroy
    @sp = Species.find(params[:id])
		if @sp.bats.length > 0
			flash[:notice] = 'Deactivation failed.  Species has bats.'
			redirect_to :action => 'show', :id => @sp
		else
			@sp.destroy
			redirect_to :action => 'list'
		end
  end
end