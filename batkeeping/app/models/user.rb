class User < ActiveRecord::Base
  has_many :cages, :order => 'name'
  has_many :cage_in_histories
  has_many :cage_out_histories
  has_and_belongs_to_many :tasks
  has_many :task_histories
  has_many :bat_changes, :order => "date desc"
  has_many :trainings
    
  validates_presence_of :name, :initials, :email
  validates_uniqueness_of :name, :initials
	
  def self.current
    find :all, :conditions => 'end_date is null', :order => 'name'
  end
	
	def self.current_weekend_care
		find :all, :conditions => "end_date is null and job_type regexp 'Weekend'", :order => 'name'
	end
	
	def self.current_medical_care
		find :all, :conditions => "end_date is null and job_type regexp 'Medic'", :order => 'name'
	end
	
	def self.current_animal_care
		find :all, :conditions => "end_date is null and job_type regexp 'Anim'", :order => 'name'
	end
	
  def self.administrator
    find :all, :conditions => "end_date is null and job_type regexp 'Admin'", :order => 'name'
  end
  
	def medical_care_user?
		if self.job_type == nil
			return false
		elsif self.job_type.include? "Med"
			return true
		else
			return false
		end
	end
	
	def weekend_care_user?
		if self.job_type == nil
			return false
		elsif self.job_type.include? "Wee"
			return true
		else
			return false
		end
	end
	
	def animal_care_user?
		if self.job_type == nil
			return false
		elsif self.job_type.include? "Ani"
			return true
		else
			return false
		end
	end
  
  def administrator?
    if self.job_type == nil
			return false
		elsif self.job_type.include? "Admin"
			return true
		else
			return false
    end
  end

  def users_bats
	users_cages = self.cages
	
	users_bats = Bat.find(:all, :conditions => ["cage_id in (?) and leave_date is null", users_cages], :order => 'band')
  end

	def bats_medical_problems #returns the users's bat's medical problems unless the user is a medical care user, in which case it returns all the medical problems
		if self.medical_care_user?
			return MedicalProblem.current
		end
		users_bats = self.users_bats
		medical_problems = Array.new
		for bat in users_bats
			for medical_problem in bat.medical_problems.current
				medical_problems << medical_problem
			end
		end
		medical_problems.sort_by{|medical_problem| [medical_problem.bat.band, medical_problem.title]}
	end

end