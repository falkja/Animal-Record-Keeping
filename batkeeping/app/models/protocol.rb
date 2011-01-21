class Protocol < ActiveRecord::Base
	has_and_belongs_to_many :bats, :order => "band"
	has_many :protocol_histories
  has_and_belongs_to_many :users, :order => "name"
	
	
	validates_presence_of :title, :number
	validates_uniqueness_of :number
	
	def self.current
		date = Date.today
		protocols = find(:all, :conditions => ["end_date >= ?",date], :order => "number")
	end

  def self.has_bats
    prots = find :all, :order => :number
    prots.delete_if{|prot| prot.bats.length == 0}
    return prots
  end

	def past_bats
		hists = ProtocolHistory.find(:all, :conditions =>["protocol_id = ? and date_removed is not null", self.id], :order => "date_removed")
		return hists
	end
	
	#looks for histories added to protocol between start and end dates
  def find_hist_btw(start_date,end_date)
		hists_bats_added_removed = ProtocolHistory.find(:all, :conditions =>["protocol_id = ? and ((date_added is not null and date_added >= ? and date_added <= ?) or (date_removed is not null and date_removed >= ? and date_removed <= ?))", self.id,start_date,end_date,start_date,end_date], :order => "date_removed")
	end

  #looks for bats active on protocol between start and end dates
  def find_active_btw(start_date,end_date)
    #for each bat:
    active_bats = Array.new
    
    #speeding things up so we don't have to iterate through all the bats...
      #loops through only the bats with protocol histories with the given protocol
    #Single query is faster:
    #SELECT DISTINCT bats.* FROM `bats` INNER JOIN `protocol_histories` ON protocol_histories.bat_id = bats.id  WHERE (protocol_histories.protocol_id = 6)
    bats = Bat.find(:all, :joins=> :protocol_histories, 
      :conditions => ["protocol_histories.protocol_id = ?",self.id],
      :select => 'DISTINCT bats.*',
      :order => 'band')
    #Two queries is slower:
#    prot_hists = ProtocolHistory.find(:all, :conditions =>["protocol_id = ?",self.id], :select => 'DISTINCT bat_id' )
#    bat_ids = prot_hists.collect(&:bat_id)
#    bats = Bat.find(bat_ids)

    for b in bats
      #step 1: find if any histories within date range, if any histories, then bat was on the protocol, return
      hists = ProtocolHistory.find(:all, :conditions =>
          ["protocol_id = ? and bat_id = ? and ((date_added is not null and date_added >= ? and
            date_added <= ?) or (date_removed is not null and date_removed >= ?
            and date_removed <= ?))",self.id,b.id,start_date,end_date,start_date,end_date])
      if hists.length > 0
        active_bats << b
      else
        #step 2: else... find the last history before date range, if (+), then +, if (-) or (..) then -
        last_hist_added = ProtocolHistory.find(:last, :conditions =>
            ["protocol_id = ? and bat_id = ? and (date_added is not null and date_added <= ?)",
            self.id,b.id,start_date],:order => "date_added")
        if last_hist_added
          last_hist_removed = ProtocolHistory.find(:last, :conditions =>
              ["protocol_id = ? and bat_id = ? and (date_removed is not null and date_removed <= ?)",
              self.id,b.id,start_date],:order => "date_removed")
          if last_hist_removed
            if last_hist_added.date_added > last_hist_removed.date_removed
              active_bats << b
            end
          else
            active_bats << b
          end
        end
      end
    end
    return active_bats
  end
end
