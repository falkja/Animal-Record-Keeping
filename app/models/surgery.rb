class Surgery < ActiveRecord::Base
  belongs_to :bat
  belongs_to :surgery_type
  belongs_to :user
  has_and_belongs_to_many :protocols
  has_and_belongs_to_many :flights
  has_one :bat_change
  
  def after_save
    bat_change = BatChange.new
    bat_change.surgery = self
		bat_change.date = self.time.to_date
		bat_change.bat = self.bat
		bat_change.note = self.note
		bat_change.user = self.user
		bat_change.save
  end
end