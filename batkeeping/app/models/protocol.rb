class Protocol < ActiveRecord::Base
	has_and_belongs_to_many :bats, :order => "band"
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
	
	def find_hist_btw(start_date,end_date)
		#looks for histories added to protocol between start and end dates
		hists_bats_added_removed = ProtocolHistory.find(:all, :conditions =>["protocol_id = ? and (date_added is not null and date_added >= ? and date_added <= ?) or (date_removed is not null and date_removed >= ? and date_removed <= ?)", self.id,start_date,end_date,start_date,end_date], :order => "date_removed")
	end
	
end
