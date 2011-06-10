class Species < ActiveRecord::Base
	has_many :bats, :order => "band"
	has_many :allowed_bats
  
	validates_presence_of :name, :lower_weight_limit, :upper_weight_limit
	
	def hibernating
		cur_mon = Date.today.mon
		if self.hibernating_start_month && self.hibernating_end_month && (self.hibernating_start_month <= cur_mon || self.hibernating_end_month >= cur_mon)
			return true
		else
			return false
		end
	end

  def self.has_bats
    #species = Species.find(:all, :order => :name)
    #species.delete_if{|sp| sp.bats.active.length == 0}
    #return species

    #Bat.active.collect{|b| b.species}.uniq

    Species.find(:all, :joins=>:bats, 
      :conditions=>"bats.species_id is not null and bats.leave_date is null",
      :select => 'DISTINCT species.*', :order => 'name')
  end

  def after_create
    for p in Protocol.all
      allowed_bat = AllowedBat.new(:protocol => p, :species => self, :number => 0)
      allowed_bat.save
    end
  end

  def before_destroy
    allowed_bats = AllowedBat.find(:all, :conditions => ["species_id = ?",self])
    allowed_bats.each{|ab| ab.destroy}
  end
end