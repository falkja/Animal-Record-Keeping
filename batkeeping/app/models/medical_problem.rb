class MedicalProblem < ActiveRecord::Base
	belongs_to :bat;
	belongs_to :user;
  has_many :proposed_treatments;
end
