class Datum < ActiveRecord::Base
  has_and_belongs_to_many :protocols, :order => "title, number"
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  def self.all
    find(:all, :order => "name")
  end
end