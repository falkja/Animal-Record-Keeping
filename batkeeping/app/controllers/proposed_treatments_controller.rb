class ProposedTreatmentsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @proposed_treatment_pages, @proposed_treatments = paginate :proposed_treatments, :per_page => 10
  end

  def show
    @proposed_treatment = ProposedTreatment.find(params[:id])
  end

  def new
    @proposed_treatment = ProposedTreatment.new
  end

  def create
    @proposed_treatment = ProposedTreatment.new(params[:proposed_treatment])
    if @proposed_treatment.save
      flash[:notice] = 'ProposedTreatment was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @proposed_treatment = ProposedTreatment.find(params[:id])
  end

  def update
    @proposed_treatment = ProposedTreatment.find(params[:id])
    if @proposed_treatment.update_attributes(params[:proposed_treatment])
      flash[:notice] = 'ProposedTreatment was successfully updated.'
      redirect_to :action => 'show', :id => @proposed_treatment
    else
      render :action => 'edit'
    end
  end

  def destroy
    ProposedTreatment.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
