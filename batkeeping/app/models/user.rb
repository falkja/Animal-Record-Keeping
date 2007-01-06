class User < ActiveRecord::Base
    has_many :cages, :order => 'name'
    has_many :bats, :order => 'band'
    has_many :cage_in_histories
    has_many :cage_out_histories
    has_many :medical_problems
    has_and_belongs_to_many :tasks
    
  def self.current
    find :all, :conditions => 'end_date is null', :order => 'name'
  end

  def self.find_ordinary_users
    find :all, :conditions => 'id > 3', :order => 'name'
  end


end