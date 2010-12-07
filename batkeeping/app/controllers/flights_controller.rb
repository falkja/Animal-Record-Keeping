class FlightsController < ApplicationController
  def index
    redirect_to :action => 'list'
  end
  
  def list
    user = User.find(session[:person])
	@bats = user.bats
	@list = "mine"
  end

  def list_current
	@bats = Bat.active
	@list = "current"
	render :action => :list
  end
  
  def list_all
    @bats = Bat.find(:all, :order => 'band')
	@list = "all"
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
	if @month.to_s == Date.today.mon.to_s
		@highlight_today = true
	else
		@highlight_today = false
	end
	if params[:id]
		@bat = Bat.find(params[:id])
	elsif params[:bat_id]#too lazy to fix this
		@bat = Bat.find(params[:bat_id])
	end
		@flight_dates, @flights  = @bat.flight_dates(@this_month.year,@this_month.mon)
	render :partial => 'remote_show', :locals=>{:bat=>@bat, :highlight_today=>@highlight_today, :this_month => @this_month, :flight_dates => @flight_dates, :flights =>@flights}
  end
  
  def new
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
	  render :partial => 'bat_select', :locals => {:bats => bats}
  end
  
  def destroy
	Flight.find(params[:id]).destroy
    redirect_to :action => 'show', :id => params[:bat]
  end
  
  def list_flight_logs_dates
	@start_date = Date.civil(params[:post][:"start_date(1i)"].to_i,params[:post][:"start_date(2i)"].to_i,params[:post][:"start_date(3i)"].to_i)
	@end_date = Date.civil(params[:post][:"end_date(1i)"].to_i,params[:post][:"end_date(2i)"].to_i,params[:post][:"end_date(3i)"].to_i)
	@bat = Bat.find(params[:id])
	
	if @start_date > @end_date
		flash[:notice] = 'Dates do not overlap'
		redirect_to :action => :show, :id => @bat
	else
		@flights = Flight.find(:all, :conditions => "bat_id = #{@bat.id} and YEAR(date) >= #{@start_date.year} AND MONTH(date) >= #{@start_date.mon} and YEAR(date) <= #{@end_date.year} AND MONTH(date) <= #{@end_date.mon}", :order => "date ASC")
	end
  end
end