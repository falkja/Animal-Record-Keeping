class MedicalProblemsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @medical_problem_pages, @medical_problems = paginate :medical_problems, :per_page => 10
  end

  def show
    @medical_problem = MedicalProblem.find(params[:id])
  end

  def new
    @medical_problem = MedicalProblem.new
  end

  def create
    @medical_problem = MedicalProblem.new(params[:medical_problem])
    if @medical_problem.save
      flash[:notice] = 'MedicalProblem was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @medical_problem = MedicalProblem.find(params[:id])
  end

  def update
    @medical_problem = MedicalProblem.find(params[:id])
    if @medical_problem.update_attributes(params[:medical_problem])
      flash[:notice] = 'MedicalProblem was successfully updated.'
      redirect_to :action => 'show', :id => @medical_problem
    else
      render :action => 'edit'
    end
  end

  def destroy
    MedicalProblem.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
