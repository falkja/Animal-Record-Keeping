class WeathersController < ApplicationController
  
  def create
    i = params[:i]
    if (params['weather' + i][:temperature] != '') && (params['weather' + i][:humidity] != '') && (params['weather' + i][:humidity].to_f <= 100) && (params['weather' + i][:humidity].to_f >= 0)
      @weather = Weather.new
      @weather.temperature = params['weather' + i][:temperature]
      @weather.humidity = params['weather' + i][:humidity]
      @weather.room = Room.find(params[:room])
      @weather.log_date = Date.today
      @weather.sig = session[:person].initials
      @weather.save
      
      flash[:note]='Temperature/humidity entry added.'
    else
      flash[:note]='There was an error in your submission.'
    end
  
    render :partial=>'enter_weathers'
  end
  
  def clear
    @weather = Weather.find(:first, :conditions=>'room_id = ' + params[:room] + ' and log_date = "' + Date.today.to_s + '"')
    @weather.destroy
    
		flash[:note]='The temperature/humidity data has been cleared.'
		
    render :partial=>'enter_weathers'
  end
end

