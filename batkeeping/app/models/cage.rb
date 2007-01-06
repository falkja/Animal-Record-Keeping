class Cage < ActiveRecord::Base
    belongs_to  :user
	has_many :bats, :order => 'band'
	has_many :cage_in_histories, :order => "date desc"
	has_many :cage_out_histories, :order => "date desc"
    has_many :tasks
  
  def self.active
    find :all, :conditions => 'date_destroyed is null'
  end
  
end