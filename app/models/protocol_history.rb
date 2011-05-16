class ProtocolHistory < ActiveRecord::Base
	belongs_to :bat
  belongs_to :protocol
	
	def self.todays_histories
    start_date=Date.today
    end_date=Date.today + 1.day
    hists = find(:all,
      :conditions => ["((add is true and date >= ? and date < ?) or (added is false and date >= ? and date < ?))",start_date,end_date,start_date,end_date])
    hists = hists.sort_by{|h| h.bat.band}
    return hists
  end
  
  def self.removed
    find :all, :conditions => 'added is false'
  end
  
end