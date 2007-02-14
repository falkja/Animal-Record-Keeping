class Weight < ActiveRecord::Base
	belongs_to :bat;
	belongs_to :user;
	
	def self.recent
		self.find(:first, :order => "date DESC")
	end
  
  def self.today
      self.find(:all, :order => "date DESC", :limit => 1, :conditions => "weights.date >= '" + Time.now.strftime("%Y-%m-%d") + "'")
  end
end
