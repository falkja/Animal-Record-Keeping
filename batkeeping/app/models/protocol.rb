class Protocol < ActiveRecord::Base
	has_and_belongs_to_many :bats
	
	
	validates_presence_of :title, :number
	validates_uniqueness_of :number
end
