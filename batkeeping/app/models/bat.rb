class Bat < ActiveRecord::Base
	belongs_to :cage
	belongs_to :protocol
end
