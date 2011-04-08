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
    @training_types = TrainingType.find(:all)
	end
  
  def show
    @training_type = TrainingType.find(params[:id])
  end
  
  def create
    # error check to make sure no training type with the same name and no null names
		if TrainingType.find(:first, :conditions => "name = '#{params[:training_type][:name]}'")
			flash[:notice] = "There is already a training type with that name.  Please choose a different name."
			redirect_to :back
		elsif params[:training_type][:name] == ''
			flash[:notice] = "Please enter a name for the training type."
			redirect_to :back
		else
			@training_type = TrainingType.new(params[:training_type])
			if @training_type.save
				flash[:notice] = 'Training type was successfully created.'
				redirect_to :controller => :trainings, :action => :new
			else
				render :action => 'new'
			end
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
	
	def remote_display_description
		training_type = TrainingType.find(params[:training_type_id])
		render :partial => 'remote_display_description', :locals => {:training_type => training_type}
	end
	
	
end