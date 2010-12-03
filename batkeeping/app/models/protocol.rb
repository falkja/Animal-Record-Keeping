class Protocol < ActiveRecord::Base
	has_and_belongs_to_many :bats
	has_many :protocol_histories
	
	
	validates_presence_of :title, :number
	validates_uniqueness_of :number
	
	def self.current
		date = Date.today
		protocols = find(:all, :conditions => ["end_date >= ?",date], :order => "number")
	end
	
	def past_bats
		hists = ProtocolHistory.find(:all, :conditions =>["protocol_id = ? and date_removed is not null", self.id], :order => "date_removed")
		bats = Array.new
		for hist in hists
		  bats << hist.bat
		end
		return bats, hists
	end
	
end
