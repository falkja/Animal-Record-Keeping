class SurgeryType < ActiveRecord::Base
  has_many :surgeries
  has_many :bats, :through => :surgeries
  has_and_belongs_to_many :protocols, :order => "title"
  
  validates_presence_of :name
  validates_uniqueness_of :name
end