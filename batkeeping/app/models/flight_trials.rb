class FlightTrials < ActiveRecord::Base
  belongs_to :flight_logs
  has_and_belongs_to_many :flight_objects
end
