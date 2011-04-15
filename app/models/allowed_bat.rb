class AllowedBat < ActiveRecord::Base
  belongs_to :protocol
  belongs_to :species

end
