class Surgery < ActiveRecord::Base
  belongs_to :bat
  belongs_to :surgery_type
  belongs_to :user
  has_and_belongs_to_many :protocols
  has_and_belongs_to_many :flights
end