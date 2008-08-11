class FlightTrialsController < ApplicationController
  # GET /flight_trials
  # GET /flight_trials.xml
  def index
    @flight_trials = FlightTrials.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @flight_trials }
    end
  end

  # GET /flight_trials/1
  # GET /flight_trials/1.xml
  def show
    @flight_trials = FlightTrials.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @flight_trials }
    end
  end

  # GET /flight_trials/new
  # GET /flight_trials/new.xml
  def new
    @flight_trials = FlightTrials.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @flight_trials }
    end
  end

  # GET /flight_trials/1/edit
  def edit
    @flight_trials = FlightTrials.find(params[:id])
  end

  # POST /flight_trials
  # POST /flight_trials.xml
  def create
    @flight_trials = FlightTrials.new(params[:flight_trials])

    respond_to do |format|
      if @flight_trials.save
        flash[:notice] = 'FlightTrials was successfully created.'
        format.html { redirect_to(@flight_trials) }
        format.xml  { render :xml => @flight_trials, :status => :created, :location => @flight_trials }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @flight_trials.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /flight_trials/1
  # PUT /flight_trials/1.xml
  def update
    @flight_trials = FlightTrials.find(params[:id])

    respond_to do |format|
      if @flight_trials.update_attributes(params[:flight_trials])
        flash[:notice] = 'FlightTrials was successfully updated.'
        format.html { redirect_to(@flight_trials) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @flight_trials.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /flight_trials/1
  # DELETE /flight_trials/1.xml
  def destroy
    @flight_trials = FlightTrials.find(params[:id])
    @flight_trials.destroy

    respond_to do |format|
      format.html { redirect_to(flight_trials_url) }
      format.xml  { head :ok }
    end
  end
end
