class ProposedTreatment < ActiveRecord::Base
	belongs_to :medical_problem;
	belongs_to :user;
  has_many :medical_care_actions;
end
