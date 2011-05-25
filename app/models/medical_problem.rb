class MedicalProblem < ActiveRecord::Base
	belongs_to :bat
	has_many :medical_treatments, :order => 'title'
  has_many :flights
  
  def self.current
      self.find(:all, :conditions => "date_closed is null")
  end
  
  def self.expired
      self.find(:all, :conditions => "date_closed is not null")
  end
  
end
