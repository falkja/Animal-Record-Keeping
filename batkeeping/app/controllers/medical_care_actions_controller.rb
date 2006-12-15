class MedicalCareActionsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @medical_care_action_pages, @medical_care_actions = paginate :medical_care_actions, :per_page => 10
  end

  def show
    @medical_care_action = MedicalCareAction.find(params[:id])
  end

  def new
    @medical_care_action = MedicalCareAction.new
    @proposed_treatment = ProposedTreatment.find(params[:id])
  end

  def create
    @medical_care_action = MedicalCareAction.new(params[:medical_care_action])
    @proposed_treatment = ProposedTreatment.find(params[:id])
    @medical_care_action.proposed_treatment = @proposed_treatment
    @medical_care_action.user = session[:person]
    if @medical_care_action.save
      flash[:notice] = 'MedicalCareAction was successfully created.'
      redirect_to :controller => 'medical_problems', :action => 'list_current'
    else
      render :action => 'new'
    end
  end

  def edit
    @medical_care_action = MedicalCareAction.find(params[:id])
  end

  def update
    @medical_care_action = MedicalCareAction.find(params[:id])
    if @medical_care_action.update_attributes(params[:medical_care_action])
      flash[:notice] = 'MedicalCareAction was successfully updated.'
      redirect_to :action => 'show', :id => @medical_care_action
    else
      render :action => 'edit'
    end
  end

  def destroy
    MedicalCareAction.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
