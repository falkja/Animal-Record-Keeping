class WeathersController < ApplicationController
  
  def create
    if (params[:weather][:temperature] != '') && (params[:weather][:humidity] != '')
    
    @weather = Weather.new
    @weather.temperature = params[:weather][:temperature]
    @weather.humidity = params[:weather][:humidity]
    @weather.room = Room.find(params[:room])
    @weather.log_date = Date.today
    @weather.sig = session[:person].initials
    @weather.save
    
    end
    
    render :partial=>'enter_weathers'
  end
end