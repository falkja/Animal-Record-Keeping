class User < ActiveRecord::Base
    has_many :cages, :order => 'name'
    has_many :cage_in_histories
    has_many :cage_out_histories
    has_and_belongs_to_many :tasks
    has_many :task_histories
    
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
	
	def medical_care_user?
		if self.job_type == nil
			return false
		end
		if self.job_type.include? "Med"
			return true
		else
			return false
		end
	end
	
	def weekend_care_user?
		if self.job_type == nil
			return false
		end
		if self.job_type.include? "Wee"
			return true
		else
			return false
		end
	end
	
	def animal_care_user?
		if self.job_type == nil
			return false
		end
		if self.job_type.include? "Ani"
			return true
		else
			return false
		end
	end

	def bats_medical_problems
		if self.medical_care_user?
			return MedicalProblem.current
		end
		users_bats = Array.new
		for cage in self.cages
			for bat in cage.bats
				users_bats << bat
			end
		end
		medical_problems = Array.new
		for bat in users_bats
			for medical_problem in bat.medical_problems
				medical_problems << medical_problem
			end
		end
		medical_problems.sort_by{|medical_problem| [medical_problem.bat.band, medical_problem.title]}
	end

end