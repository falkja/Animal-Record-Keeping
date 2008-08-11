class FlightLogsController < ApplicationController
  # GET /flight_logs
  # GET /flight_logs.xml
  def index
    @flight_logs = FlightLogs.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @flight_logs }
    end
  end

  # GET /flight_logs/1
  # GET /flight_logs/1.xml
  def show
    @flight_logs = FlightLogs.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @flight_logs }
    end
  end

  # GET /flight_logs/new
  # GET /flight_logs/new.xml
  def new
    @flight_logs = FlightLogs.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @flight_logs }
    end
  end

  # GET /flight_logs/1/edit
  def edit
    @flight_logs = FlightLogs.find(params[:id])
  end

  # POST /flight_logs
  # POST /flight_logs.xml
  def create
    @flight_logs = FlightLogs.new(params[:flight_logs])

    respond_to do |format|
      if @flight_logs.save
        flash[:notice] = 'FlightLogs was successfully created.'
        format.html { redirect_to(@flight_logs) }
        format.xml  { render :xml => @flight_logs, :status => :created, :location => @flight_logs }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @flight_logs.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /flight_logs/1
  # PUT /flight_logs/1.xml
  def update
    @flight_logs = FlightLogs.find(params[:id])

    respond_to do |format|
      if @flight_logs.update_attributes(params[:flight_logs])
        flash[:notice] = 'FlightLogs was successfully updated.'
        format.html { redirect_to(@flight_logs) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @flight_logs.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /flight_logs/1
  # DELETE /flight_logs/1.xml
  def destroy
    @flight_logs = FlightLogs.find(params[:id])
    @flight_logs.destroy

    respond_to do |format|
      format.html { redirect_to(flight_logs_url) }
      format.xml  { head :ok }
    end
  end
end
