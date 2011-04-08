class BatNote < ActiveRecord::Base
	belongs_to :bat
	belongs_to :user
	
end