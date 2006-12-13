class MedicalProblemsController < ApplicationController
  def index
    redirect_to :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @medical_problem_pages, @medical_problems = paginate :medical_problems,  :order => 'bat_id', :per_page => 10, :conditions => "date_closed is null"
    @list_all = false
  end

  def list_all
    @medical_problem_pages, @medical_problems = paginate :medical_problems,  :order => 'bat_id', :per_page => 10
    @list_all = true
    render :action => 'list'
  end
  
  def show
    @medical_problem = MedicalProblem.find(params[:id])
  end

  def new
    @medical_problem = MedicalProblem.new
    @bats = Bat.find(:all, :conditions => "leave_date is null", :order => "band")
    @deactivating = false
  end

  def create
    @bat = Bat.find(params[:bat][:id])
    @medical_problem = MedicalProblem.new(params[:medical_problem])
    @medical_problem.date_closed = nil
    @medical_problem.bat = @bat
    @medical_problem.user = session[:person]
    
    proposed_treatment = ProposedTreatment.new(params[:proposed_treatment])
    proposed_treatment.date_started = Time.now
    proposed_treatment.date_closed = nil
    proposed_treatment.user = session[:person]
    proposed_treatment.medical_problem = @medical_problem
    proposed_treatment.save
    
    if @medical_problem.save
      flash[:notice] = 'MedicalProblem was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @bats = Bat.find(:all, :conditions => "leave_date is null", :order => "band")
    @medical_problem = MedicalProblem.find(params[:id])
    @deactivating = false
  end

  def update
    @medical_problem = MedicalProblem.find(params[:id])
    if @proposed_treatment = ProposedTreatment.find(params[:id])
      @proposed_treatment.date_closed = Time.now
      @proposed_treatment.save
    end
    if @medical_problem.update_attributes(params[:medical_problem])
      flash[:notice] = 'MedicalProblem was successfully updated.'
	  if params[:redirectme] == 'list'
		redirect_to :action => 'list'
	  else
		redirect_to :action => 'show', :id => @bat
	  end
    else
      render :action => 'edit'
    end
  end

  def destroy
    MedicalProblem.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def deactivate
	@medical_problem = MedicalProblem.find(params[:id])
  @bats = Bat.find(:all, :conditions => "leave_date is null", :order => "band")
  @proposed_treatment = ProposedTreatment.find(params[:id])
  @deactivating = true
  end
  
  def reactivate
    @medical_problem = MedicalProblem.find(params[:id])
    @medical_problem.date_closed = nil
    @medical_problem.save
    @proposed_treatment = ProposedTreatment.find(params[:id])
    @proposed_treatment.date_closed = nil
    @proposed_treatment.save
    redirect_to :action => 'list'
  end
end
