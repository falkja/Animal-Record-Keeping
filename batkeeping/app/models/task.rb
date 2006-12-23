class Task < ActiveRecord::Base
  has_many :users
  belongs_to :cage
  belongs_to :proposed_treatment
end
