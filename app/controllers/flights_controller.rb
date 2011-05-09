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
    @dates = Hash.new
    @flights.each{|f| @dates[ f.date.strftime("%d").to_i ] = "<a href=\"#\" onclick=\"new Ajax.Updater(\'f_entry_display\', \'/flights/remote_flights_entry_list?flight=" + f.id.to_s + "\', {asynchronous:true, evalScripts:true}); return false;\">" + f.date.strftime("%d").to_i.to_s + "</a>"}
  end
  
  def remote_show
    @this_month = Date.strptime(params[:this_month])
    if @month.to_s == Date.today.mon.to_s
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

      dates = Hash.new
      @flights.each{|f| dates[ f.date.strftime("%d").to_i ] = "<a href=\"#\" onclick=\"new Ajax.Updater(\'f_entry_display\', \'/flights/remote_flights_entry_list?flight=" + f.id.to_s + "\', {asynchronous:true, evalScripts:true}); return false;\">" + f.date.strftime("%d").to_i.to_s + "</a>"}

      render :partial => 'remote_show', :locals=>{:bat=>@bat, 
        :highlight_today=>@highlight_today, :this_month => @this_month, 
        :flight_dates => @flight_dates, :flights =>@flights, :dates => dates}
    else
      render :nothing => true
    end
  end
  
  def new
    if params[:bat]
      @bat = Bat.find(params[:bat])
      @bats = Array.new
      @bats << @bat
    else
      @bats = User.find(session[:person]).bats
    end
    @flight = Flight.new
  end
  
  def create
    if params[:showing_only]
      redirect_to :action => :show, :id => params[:id]
    else
      @flight = Flight.new(params[:flight])
		
      if @flight.date > Date.today
        flash[:notice] = 'Flight date cannot be in the future.'
        render :action => :new
      else
        @flight.user = User.find(session[:person])
        if @flight.save
          flash[:notice] = 'Flight was successfully created.'
          redirect_to :action => :show, :id => @flight.bat
        else
          render :action => :new
        end
      end
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