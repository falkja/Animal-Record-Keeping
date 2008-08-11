class FlightObjects < ActiveRecord::Base
  has_and_belongs_to_many :flight_trials
end
