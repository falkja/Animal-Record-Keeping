class MedicalCareAction < ActiveRecord::Base
	belongs_to :proposed_treatment;
	belongs_to :user;
   
  def self.today
      self.find(:all, :conditions => "medical_care_actions.date >= '" + Time.now.strftime("%Y-%m-%d") + "'")
  end
end
