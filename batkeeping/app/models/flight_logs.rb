class FlightLogs < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :bat
  has_many :flight_trials, :order => "number asc"
  
end
