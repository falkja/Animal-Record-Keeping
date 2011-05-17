class SurgeryType < ActiveRecord::Base
  has_many :surgeries
  has_many :bats, :through => :surgeries
  
  validates_presence_of :name
  validates_uniqueness_of :name
end