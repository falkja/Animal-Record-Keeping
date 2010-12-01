class FlightsController < ApplicationController
  def index
    redirect_to :action => 'list'
  end
  
  def list
	@bats = Bat.active
    @list = "current"
  end
  
  def list_all
    @bats = Bat.find(:all, :order => 'band')
    @list = "all"
    render :action => 'list'
  end

  def list_deactivated
	@bats = Bat.find(:all, :conditions => 'leave_date is not null', :order => 'band')
	@list = "deactivated"
	render :action => 'list'
  end
  
  def show
	@year = Date.today.year
	@month = Date.today.mon
	@bat = Bat.find(params[:id])
	@flight_dates, @flights  = @bat.flight_dates(@year,@month)
  end
  
  def remote_show
	@month = params[:month]
	@year = params[:year]
	if @month.to_i > 12
		@month = 1;
		@year = @year.to_i + 1
	elsif @month.to_i < 1
		@month = 12;
		@year = @year.to_i - 1
	end
	if @month.to_s == Date.today.mon.to_s
		@highlight_today = true
	else
		@highlight_today = false
	end
	@bat = Bat.find(params[:id])
	@flight_dates, @flights  = @bat.flight_dates(@year,@month)
	render :partial => 'remote_show', :locals=>{:bat=>@bat, :highlight_today=>@highlight_today, :year=>@year, :month=>@month, :flight_dates => @flight_dates, :flights =>@flights}
  end
end