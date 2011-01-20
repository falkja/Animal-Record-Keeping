class ProtocolHistory < ActiveRecord::Base
	belongs_to :bat
  belongs_to :protocol
	
	
end