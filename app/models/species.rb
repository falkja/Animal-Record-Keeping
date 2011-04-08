class Species < ActiveRecord::Base
	has_many :bats, :order => "band"
	
	validates_presence_of :name, :lower_weight_limit, :upper_weight_limit
	
	def hibernating
		cur_mon = Date.today.mon
		if self.hibernating_start_month && self.hibernating_end_month && (self.hibernating_start_month <= cur_mon || self.hibernating_end_month >= cur_mon)
			return true
		else
			return false
		end
	end
end