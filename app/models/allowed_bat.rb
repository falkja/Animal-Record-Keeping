class AllowedBat < ActiveRecord::Base
  belongs_to :protocol
  belongs_to :species

  validates_presence_of :number, :species
  validates_numericality_of :number, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :warning_limit, :only_integer => true, :greater_than_or_equal_to => 0
  
  def validate
    if self.number < self.warning_limit
      errors.add(:warning_limit,"cannot be above number allowed")
    elsif self.number < Bat.on_species(self.protocol.all_past_bats,self.species).length
      errors.add(:number,"cannot be below bats used on protocol")
    end
  end
end