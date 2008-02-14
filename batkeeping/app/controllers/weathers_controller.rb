class WeathersController < ApplicationController
  require "gruff"
  def create
    i = params[:i]
    if (params['weather' + i][:temperature] != '') && (params['weather' + i][:humidity] != '') && (params['weather' + i][:humidity].to_f <= 100) && (params['weather' + i][:humidity].to_f >= 0)
      @weather = Weather.new
      @weather.temperature = params['weather' + i][:temperature]
      @weather.humidity = params['weather' + i][:humidity]
      @weather.room = Room.find(params[:room])
      @weather.log_date = Date.today
      @weather.sig = User.find(session[:person]).initials
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
  
  def graph_weathers
    room = Room.find(params[:room])
    weathers = Weather.find(:all, :conditions => "room_id = #{room.id}", :order => 'log_date')
    
    temps = Array.new
    hums = Array.new
    dates = Array.new
    
    for weather in weathers
      temps << weather.temperature
      hums << weather.humidity
      dates << weather.log_date.strftime('%m-%d-%y')
    end
    
    dates_reduced = Hash.new
    spacing = (dates.length/6.0).ceil
    0.step( dates.length-1, spacing) {|i|  dates_reduced[i] = dates[i] }
    
    g = Gruff::Line.new(800)
    
    g.title = room.name + " Temperature and Humidity"
    g.data('Temperature', temps)
    g.data('Humidity', hums)
    
    g.labels = dates_reduced
    
    send_data(g.to_blob, :disposition => 'inline', :type => 'image/png', :filename => room.name + " Temperature and Humidity.png")
  end
end

