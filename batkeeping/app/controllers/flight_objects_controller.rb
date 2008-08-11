class FlightObjectsController < ApplicationController
  # GET /flight_objects
  # GET /flight_objects.xml
  def index
    @flight_objects = FlightObjects.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @flight_objects }
    end
  end

  # GET /flight_objects/1
  # GET /flight_objects/1.xml
  def show
    @flight_objects = FlightObjects.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @flight_objects }
    end
  end

  # GET /flight_objects/new
  # GET /flight_objects/new.xml
  def new
    @flight_objects = FlightObjects.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @flight_objects }
    end
  end

  # GET /flight_objects/1/edit
  def edit
    @flight_objects = FlightObjects.find(params[:id])
  end

  # POST /flight_objects
  # POST /flight_objects.xml
  def create
    @flight_objects = FlightObjects.new(params[:flight_objects])

    respond_to do |format|
      if @flight_objects.save
        flash[:notice] = 'FlightObjects was successfully created.'
        format.html { redirect_to(@flight_objects) }
        format.xml  { render :xml => @flight_objects, :status => :created, :location => @flight_objects }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @flight_objects.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /flight_objects/1
  # PUT /flight_objects/1.xml
  def update
    @flight_objects = FlightObjects.find(params[:id])

    respond_to do |format|
      if @flight_objects.update_attributes(params[:flight_objects])
        flash[:notice] = 'FlightObjects was successfully updated.'
        format.html { redirect_to(@flight_objects) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @flight_objects.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /flight_objects/1
  # DELETE /flight_objects/1.xml
  def destroy
    @flight_objects = FlightObjects.find(params[:id])
    @flight_objects.destroy

    respond_to do |format|
      format.html { redirect_to(flight_objects_url) }
      format.xml  { head :ok }
    end
  end
end
