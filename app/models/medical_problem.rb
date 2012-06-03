class MedicalProblem < ActiveRecord::Base
	belongs_to :bat
	has_many :medical_treatments, :order => 'title'
  has_many :flights
  
  def self.current
      self.find(:all, :conditions => "date_closed is null")
  end
  
  def self.expired
      self.find(:all, :conditions => "date_closed is not null")
  end
  
  def self.search(search)
    if !search.empty?
      find(:all, 
        :joins=> :medical_treatments,
        :conditions => ['description LIKE ? OR medical_problems.title LIKE ? OR medical_treatments.title LIKE ?', "%#{search}%","%#{search}%","%#{search}%"],
        :select => 'DISTINCT medical_problems.*', :order =>'title')
    else
      return []
    end
  end
  
end
