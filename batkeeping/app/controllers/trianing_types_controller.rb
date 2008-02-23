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
end