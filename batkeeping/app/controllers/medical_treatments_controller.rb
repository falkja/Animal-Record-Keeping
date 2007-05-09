class MedicalTreatmentsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @medical_treatments = MedicalTreatment.find(:all)
  end

  def show
    @medical_treatment = MedicalTreatment.find(params[:id])
  end

  def new
    @medical_treatments = MedicalTreatment.new
		@medical_problem = MedicalProblem.find(params[:id])
  end

  def create
    @medical_problem = MedicalProblem.find(params[:id])
		@medical_treatment = MedicalTreatment.new(params[:medical_treatment])
		@medical_treatment.medical_problem = @medical_problem
    if @medical_treatment.save
      flash[:notice] = 'Medical treatment was successfully created.'
      redirect_to :action => 'show', :id=>@medical_treatment
    else
      render :action => 'new'
    end
  end

  def edit
    @medical_treatment = MedicalTreatment.find(params[:id])
  end

  def update
    @medical_treatment = MedicalTreatment.find(params[:id])
    if @medical_treatment.update_attributes(params[:medical_treatments])
      flash[:notice] = 'MedicalTreatments was successfully updated.'
      redirect_to :action => 'show', :id => @medical_treatment
    else
      render :action => 'edit'
    end
  end
	
	def destroy_medical_treatment
		medical_treatment = MedicalTreatment.find(params[:id])
    medical_treatment.end_treatment
    redirect_to :controller => 'medical_problems', :action => 'list_current'
	end
end
