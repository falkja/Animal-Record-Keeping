class WeathersController < ApplicationController
  
  def create
    if (params[:weather][:temperature] != '') && (params[:weather][:humidity] != '') && (params[:weather][:humidity].to_f <= 100)
      @weather = Weather.new
      @weather.temperature = params[:weather][:temperature]
      @weather.humidity = params[:weather][:humidity]
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
    gfd
    @weather = Weather.find(:first, :conditions=>'room_id = ' + params[:room] + ' log_date = ' + Date.today)
    @weather.delete
    @weather.save
    asd
    
    render :partial=>'enter_weathers'
  end
end