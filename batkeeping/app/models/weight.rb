class Weight < ActiveRecord::Base
	belongs_to :bat
	belongs_to :user
  has_many :task_histories
	
	def self.recent
		self.find(:first, :order => "date DESC")
	end
  
	#returns a weight.weight = 0 instead of nil for sorting
	def self.recent_never_nil
		weight = self.find(:first, :order => "date DESC")
		if weight != nil then return weight 
		else	
			weight = Weight.new
			weight.weight = 0
			return weight 
		end
	end
  
	def self.today
		self.find(:first, :order => "date DESC", :conditions => "weights.date >= '#{Time.now.strftime("%Y-%m-%d")}'")
	end
end
