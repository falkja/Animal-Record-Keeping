class ProposedTreatment < ActiveRecord::Base
	belongs_to :medical_problem;
	belongs_to :user;
end
