class User < ActiveRecord::Base
  has_many :cages, :order => 'name'
  has_many :cage_in_histories
  has_many :cage_out_histories
  has_and_belongs_to_many :tasks
  has_many :task_histories
  has_many :bat_changes, :order => "date desc"
  has_many :trainings
    
  def self.current
    find :all, :conditions => 'end_date is null', :order => 'name'
  end
	
	def self.current_weekend_care
		find :all, :conditions => "end_date is null and job_type REGEXP 'Weekend Care'", :order => 'name'
	end
	
	def self.current_medical_care
		find :all, :conditions => "end_date is null and job_type REGEXP 'Medical Care'", :order => 'name'
	end
	
	def self.current_animal_care
		find :all, :conditions => "end_date is null and job_type REGEXP 'Animal Care'", :order => 'name'
	end
	
  def self.administrator
    find :all, :conditions => "end_date is null and job_type REGEXP 'Administrator'", :order => 'name'
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
    users_bats = Array.new
    for cage in self.cages
			for bat in cage.bats
				users_bats << bat
			end
		end
    return users_bats
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