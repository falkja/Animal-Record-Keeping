class Protocol < ActiveRecord::Base
	has_and_belongs_to_many :bats, :order => "band"
	has_many :protocol_histories, :order => "date desc"
  has_many :allowed_bats
  has_and_belongs_to_many :data, :order => "name"
  has_and_belongs_to_many :users, :order => "name"
  has_and_belongs_to_many :surgery_types, :order => "name"
  has_and_belongs_to_many :surgeries, :order => "time desc"
  
  accepts_nested_attributes_for :allowed_bats
		
	validates_presence_of :title, :number
	validates_uniqueness_of :number
	
	def self.current
		date = Date.today
		find(:all, :conditions => ["end_date >= ?",date], :order => "number")
	end

  def self.has_bats
    prots = find :all, :order => :number
    prots.delete_if{|prot| prot.bats.length == 0}
    return prots
  end

  def build_allowed_bats
    self.allowed_bats = Array.new
    for sp in Species.all.sort_by{|s| s.name}
      ab = AllowedBat.new
      ab.number = 0
      ab.species = sp
      ab.protocol = self
      self.allowed_bats << ab
    end
  end

  def allowed_bats_by_species(species)
    self.allowed_bats.find(:first, :conditions => "species_id = #{species.id}")
  end

  def check_allowed_bats(adding_bats)
    species = adding_bats.collect(&:species).uniq
    for sp in species
      ab = allowed_bats_by_species(sp)
      tot_bats = Bat.bats_on_species(((self.all_past_bats + adding_bats).uniq),sp)
      if ab.number < tot_bats.length
        return false
      end
    end
    return true
  end

  def all_past_bats
    Bat.find(:all, :joins=> :protocol_histories,
      :conditions => ["protocol_histories.protocol_id = ?",self.id],
      :select => 'DISTINCT bats.*',
      :order => 'band')
  end

	def past_hists
		ProtocolHistory.find(:all, :conditions =>["protocol_id = ? and added is false", self.id], :order => "date")
	end
	
	#looks for histories added to protocol between start and end dates
  def find_hist_btw(start_date,end_date)
		ProtocolHistory.find(:all, :conditions =>["protocol_id = ? and ((added is true and date >= ? and date <= ?) or (added is false and date >= ? and date <= ?))", 
        self.id,start_date,end_date,start_date,end_date], :order => "date")
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
          ["protocol_id = ? and bat_id = ? and ((added is true and date >= ? and
            date <= ?) or (added is false and date >= ?
            and date <= ?))",self.id,b.id,start_date,end_date,start_date,end_date])
      if hists.length > 0
        active_bats << b
      else
        #step 2: else... find the last history before date range, if (+), then +, if (-) or (..) then -
        last_hist_added = ProtocolHistory.find(:last, :conditions =>
            ["protocol_id = ? and bat_id = ? and (added is true and date <= ?)",
            self.id,b.id,start_date],:order => "date")
        if last_hist_added
          last_hist_removed = ProtocolHistory.find(:last, :conditions =>
              ["protocol_id = ? and bat_id = ? and (added is false and date <= ?)",
              self.id,b.id,start_date],:order => "date")
          if last_hist_removed
            if last_hist_added.date > last_hist_removed.date
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

  def determine_allowed_bats(species)
    allowed_bat = AllowedBat.find(:first, :conditions =>
        ["protocol_id = ? and species_id = ?",self.id,species.id])
    if allowed_bat
      return allowed_bat.number
    else
      return 0
    end
  end
end
