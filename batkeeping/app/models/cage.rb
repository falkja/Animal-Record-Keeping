class Cage < ActiveRecord::Base
	has_many :bats, :order => 'band'
end
