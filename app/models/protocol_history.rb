class ProtocolHistory < ActiveRecord::Base
	belongs_to :bat
  belongs_to :protocol
	
	def self.todays_histories
    start_date=Date.today
    end_date=Date.today + 1.day
    hists = find(:all,
      :conditions => ["((date_added is not null and date_added >= ? and date_added < ?) or (date_removed is not null and date_removed >= ? and date_removed < ?))",start_date,end_date,start_date,end_date])
    hists = hists.sort_by{|h| h.bat.band}
    return hists
  end
end