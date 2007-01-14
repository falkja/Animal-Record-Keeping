# Filters added to this controller will be run for all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
class ApplicationController < ActionController::Base
	layout 'standard'

  session_times_out_in 15.minutes, :after_timeout => :send_to_login
    
	def send_to_login
    redirect_to :controller => 'main', :action => 'timeout'
    end

    #given an array of cages, returns number of bats in them
    def bats_in_cages(cages)
		bats = Array.new
    	cages.each {|cage| bats << cage.bats}
    	bats.flatten!
    end
end