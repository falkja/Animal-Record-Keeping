class User < ActiveRecord::Base
  has_many :cages, :order => 'name'
  has_many :cage_in_histories
  has_many :cage_out_histories
  has_and_belongs_to_many :tasks, :order => "repeat_code, title"
  has_many :task_histories
  has_many :bat_changes, :order => "date desc"
  has_many :trainings
  has_many :bats, :through => :cages, :order => "band"
  has_and_belongs_to_many :protocols, :order => "number"
  has_many :surgeries
  has_many :protocol_histories
  
    
  validates_presence_of :name, :initials, :email
  validates_uniqueness_of :name, :initials
	
  def self.current
    find :all, :conditions => 'end_date is null', :order => 'name'
  end
	
	def self.current_weekend_care
		find :all, :conditions => "end_date is null and weekend_care is true", :order => 'name'
	end
	
	def self.current_medical_care
		find :all, :conditions => "end_date is null and medical_care is true", :order => 'name'
	end
	
	def self.current_animal_care
		find :all, :conditions => "end_date is null and animal_care is true", :order => 'name'
	end
	
  def self.administrator
    find :all, :conditions => "end_date is null and administrator is true", :order => 'name'
  end
	
  def self.not_researcher
    find :all, :conditions => "end_date is null and researcher is false", :order => 'name'
  end

	def bats_medical_problems #returns the user's bat's medical problems unless the user is a medical care user, in which case it returns all the medical problems
		if self.medical_care
			return MedicalProblem.current
		end
		users_bats = self.bats
		medical_problems = Array.new
		for bat in users_bats
			for medical_problem in bat.medical_problems.current
				medical_problems << medical_problem
			end
		end
		medical_problems.sort_by{|medical_problem| [medical_problem.bat.band, medical_problem.title]}
	end

  def all_tasks
    users_tasks = self.tasks.today

    if ((self.animal_care && ( (Time.now.wday == 1) || (Time.now.wday == 2) || (Time.now.wday == 3) || (Time.now.wday == 4) || (Time.now.wday == 5))) || (self.weekend_care && (Time.now.wday == 6 || Time.now.wday == 0)))
      users_tasks = Task.animal_care_user_general_tasks_today | users_tasks
      users_tasks = Task.animal_care_user_feeding_tasks_today | users_tasks
    end

    if self.medical_care
      users_tasks = Task.medical_user_tasks_today | users_tasks
    end

    if self.cages.active.length > 0
      self.cages.active.each{|c| c.tasks.today.length > 0 ? c.tasks.today.each{|t| users_tasks << t} : ''}
    end

    return users_tasks.uniq
  end
  
  def has_jobs
    return (self.administrator || self.animal_care || self.medical_care || self.researcher || self.weekend_care)
  end
  
  def jobs
    jobs = Array.new
    self.researcher ? jobs << "Researcher" : ''
    self.administrator ? jobs << "Administrator": '' 
    self.animal_care ? jobs << "Animal Care":'' 
    self.weekend_care ? jobs << "Weekend Care":'' 
    self.medical_care ? jobs << "Medical Care":'' 
    return jobs
  end

end