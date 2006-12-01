class Weight < ActiveRecord::Base
	belongs_to :bat;
	belongs_to :user;
end
