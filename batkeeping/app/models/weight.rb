class Weight < ActiveRecord::Base
	belongs_to :bat;
	belongs_to :user;
	
	def self.recent
		find(:all, :order => "date DESC", :limit => 5)
	end
end
