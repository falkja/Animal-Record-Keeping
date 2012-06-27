# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
	layout 'standard'

	session_times_out_in 15.minutes, :after_timeout => :send_to_login
    
	def send_to_login
    redirect_to :controller => 'main', :action => 'timeout'
    end
	
end