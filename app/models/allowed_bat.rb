class AllowedBat < ActiveRecord::Base
  belongs_to :protocol
  has_one :species

end
