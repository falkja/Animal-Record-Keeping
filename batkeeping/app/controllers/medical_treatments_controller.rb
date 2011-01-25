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
		@users = User.current
		@task_histories = @medical_treatment.task_histories
  end

  def auto_complete_treatments
    @medical_treatments = MedicalTreatment.find(:all, 
      :conditions => ['title LIKE ?', "%#{params[:search]}%"],
      :select => 'DISTINCT medical_treatments.title',
      :limit => 10)
    render :partial => 'auto_complete_treatments'
  end

  def new
    @medical_treatments = MedicalTreatment.find(:all)
    @medical_treatment = MedicalTreatment.new
		@medical_problem = MedicalProblem.find(params[:id])
  end

  def create
    if (params[:medical_treatment][:title] == '')
      flash[:notice] = 'There were problems with your submission.  Please make sure all data fields are filled out.'
      redirect_to :back
    else
      @medical_problem = MedicalProblem.find(params[:id])
      @medical_treatment = MedicalTreatment.new(params[:medical_treatment])
      @medical_treatment.medical_problem = @medical_problem
      if @medical_treatment.save
        flash[:notice] = 'Medical treatment was successfully created.'
        redirect_to :action => 'show', :id=>@medical_treatment
        
        #making a new bat changes entry
        bat_change = BatChange.new      
        bat_change.date = @medical_treatment.date_opened
        bat_change.bat = @medical_treatment.medical_problem.bat
        bat_change.note = "STARTED TREATMENT FOR: " + @medical_treatment.medical_problem.title
        bat_change.medical_treatment = @medical_treatment
        bat_change.user = User.find(session[:person])
        bat_change.save
        
      else
        render :action => 'new'
      end
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
		treatment = MedicalTreatment.find(params[:id])
    treatment.end_treatment
    
    bat_change = BatChange.new      
    bat_change.date = treatment.date_closed
    bat_change.bat = treatment.medical_problem.bat
    bat_change.note = "ENDED TREATMENT FOR: " + treatment.medical_problem.title
    bat_change.medical_treatment = treatment
    bat_change.user = User.find(session[:person])
    bat_change.save
    
    redirect_to :controller => 'medical_problems', :action => 'list_current'
	end
end