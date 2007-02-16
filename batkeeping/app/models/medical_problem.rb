class MedicalProblem < ActiveRecord::Base
	belongs_to :bat
	belongs_to :user
	has_many :tasks
  
  def self.current
      self.find(:all, :conditions => "date_closed is null")
  end
  
  def self.expired
      self.find(:all, :conditions => "date_closed is not null")
  end
  
end
