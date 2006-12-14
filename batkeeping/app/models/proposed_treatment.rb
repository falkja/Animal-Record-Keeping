class ProposedTreatment < ActiveRecord::Base
	belongs_to :medical_problem;
	belongs_to :user;
  has_many :medical_care_actions;
  
  def self.current
      self.find(:all, :conditions => "date_closed is null")
  end
  
  def self.expired
      self.find(:all, :conditions => "date_closed is not null")
  end
  
end
