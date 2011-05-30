class FlightsController < ApplicationController
  def index
    redirect_to :action => 'list'
  end
  
  def list
    user = User.find(session[:person])
    @bats = user.bats
  end

  def list_current
    @bats = Bat.active
    render :action => :list
  end
  
  def list_all
    @bats = Bat.find(:all, :order => 'band')
    render :action => 'list'
  end
  
  def list_exempt
    @bats = Bat.exempt_from_flight
    render :action => 'list'
  end

  def list_non_exempt
    @bats = Bat.not_exempt_from_flight
    render :action => 'list'
  end
  
  def list_deactivated
    @bats = Bat.not_active
    @list = "deactivated"
    render :action => 'list'
  end
  
  def show
    @bat = Bat.find(params[:id])
    @flight_dates, @flights  = @bat.flight_dates(Date.today.year,Date.today.mon)
  end
  
  def remote_show
    @this_month = Date.strptime(params[:this_month])
    if @this_month.mon == Date.today.mon && @this_month.year == Date.today.year
      @highlight_today = true
    else
      @highlight_today = false
    end
    if params[:id]
      @bat = Bat.find(params[:id])
    elsif params[:bat_id] && params[:bat_id]!=""#too lazy to fix this
      @bat = Bat.find(params[:bat_id])
    end
    if @bat
      @flight_dates, @flights  = @bat.flight_dates(@this_month.year,@this_month.mon)

      render :partial => 'remote_show', :locals=>{:bat=>@bat, 
        :highlight_today=>@highlight_today, :this_month => @this_month, 
        :flight_dates => @flight_dates, :flights =>@flights}
    else
      render :nothing => true
    end
  end
  
  def new
    if params[:bat]
      @bat = Bat.find(params[:bat])
      @bats = Array.new
      @bats << @bat
    elsif params[:bats]
      @bats = Bat.find(params[:bats])
    else
      @bats = User.find(session[:person]).bats
    end
    @flight = Flight.new
  end
  
  def create
    if params[:showing_only]
      redirect_to :action => :show, :id => params[:id]
    else
      bats = Array.new
      if params[:bat_id]
        params[:bat_id].each{|id, checked| checked=='1' ? bats << Bat.find(id) : '' }
      end

      if bats.length > 0

        for bat in bats
          flight = Flight.new(params[:flight])
          if flight.date > Date.today
            flash[:notice] = 'Flight date cannot be in the future.'
            redirect_to :action => :new, :bats => bats and return
          end
          flight.user = User.find(session[:person])
          flight.bat = bat
          flight.save
        end
      else
        flash[:notice] = 'Select a bat.'
        redirect_to :action => :new and return
      end

      redirect_to :controller => :bats, :action => :list, :bats => bats
    end
  end
  
  def remote_bat_list
    if params[:sort_by]=='leave_date'
      bats = Bat.find(params[:bats], :order => "-leave_date asc, band")
    else
      bats = Bat.find(params[:bats], :order => "band")
    end
	
    render :partial => 'bat_list', :locals => {:bat_list => bats}
  end
  
  def remote_bat_select
	  if params[:bats]
      bats = Bat.find(params[:bats], :order => "band")
    elsif params[:cage] && params[:cage][:id] != ""
      bats = Cage.find(params[:cage][:id]).bats
    elsif params[:room] && params[:room][:id]
      bats = Room.find(params[:room][:id]).bats
    elsif params[:protocol] && params[:protocol][:id]
      bats = Protocol.find(params[:protocol][:id]).bats
	  else
      bats = Array.new
	  end
	  render :partial => 'bat_select', :locals => {:bats => bats, :bat => nil}
  end
  
  def destroy
    Flight.find(params[:id]).destroy
    redirect_to :action => 'show', :id => params[:bat]
  end
  
  def list_flight_logs_dates
    @start_date = Date.civil(params[:post][:"start_date(1i)"].to_i,params[:post][:"start_date(2i)"].to_i,params[:post][:"start_date(3i)"].to_i)
    @end_date = Date.civil(params[:post][:"end_date(1i)"].to_i,params[:post][:"end_date(2i)"].to_i,-1)
    @bat = Bat.find(params[:id])
	
    if @start_date > @end_date
      flash[:notice] = 'Dates do not overlap'
      redirect_to :action => :show, :id => @bat
    else
      @flights = Flight.find(:all, :conditions => ["bat_id = #{@bat.id} and date >= ? and date <= ?",@start_date,@end_date], :order => "date ASC")
    end
  end

  def remote_flights_entry_list
    if params[:flight]
      flights = Array.new
      flights << Flight.find(params[:flight])
    else
      flights = Flight.find(params[:flights])
    end
    render :partial => 'flights/flights_listing', :locals => { :flights => flights }
  end
end