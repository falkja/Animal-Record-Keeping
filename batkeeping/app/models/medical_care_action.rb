class MedicalCareAction < ActiveRecord::Base
	belongs_to :proposed_treatment;
	belongs_to :user;
end
