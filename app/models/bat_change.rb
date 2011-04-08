class BatChange < ActiveRecord::Base
  belongs_to :bat
  belongs_to :medical_treatment
  belongs_to :user
  belongs_to :cage_in_history
  
end