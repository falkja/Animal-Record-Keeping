class TrainingTypesController < ApplicationController
	def index
    list
    render :action => 'list'
  end
	
	def list
    @training_types = TrainingType.find(:all)
  end
	
	def new
		@training_type = TrainingType.new
	end
  
  def show
    @training_type = TrainingType.find(params[:id])
  end
  
  def create
    @training_type = TrainingType.new(params[:training_type])
    if @training_type.save
      flash[:notice] = 'Training type was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end
  
  def edit
    @training_type = TrainingType.find(params[:id])
  end
  
  def update
    @training_type = TrainingType.find(params[:training_type])
    if @training_type.update_attributes(params[:training_type])
      flash[:notice] = 'Training type was successfully updated.'
      redirect_to :action => 'show', :id => @training_type
    else
      render :action => 'edit'
    end
  end

  def destroy
    @training_type = TrainingType.find(params[:id])
    
    if @training_type.trainings.length > 0
      flash[:notice] = 'Deactivation failed.  Training type still has users trained.'
			redirect_to :action => 'show', :id => @training_type
		else
      @training_type.destroy
      redirect_to :action => 'list'
    end
  end
  
end