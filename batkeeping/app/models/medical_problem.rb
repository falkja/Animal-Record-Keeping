class MedicalProblem < ActiveRecord::Base
	belongs_to :bat;
	belongs_to :user;
  has_many :proposed_treatments;
  
  def self.current
      self.find(:all, :conditions => "date_closed is null")
  end
  
end
