class MedicalProblemsController < ApplicationController
  def index
    redirect_to :action => 'list_current'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    render :action => 'list'
  end

  def list_current
    @medical_problems = MedicalProblem.current
		@medical_problems = @medical_problems.sort_by{|medical_problem| [medical_problem.bat.cage.name, medical_problem.bat.band, medical_problem.title]}
    @list_all = false
    list
  end

  def list_all
    @medical_problems = MedicalProblem.find(:all)
		@medical_problems = @medical_problems.sort_by{|medical_problem| [medical_problem.bat.cage ? medical_problem.bat.cage.name : '', medical_problem.bat.band, medical_problem.title]}
    @list_all = true
    list
  end
  
	def sort_by
		if params[:sorted_by] == 'medical_problem'
			medical_problems = MedicalProblem.find(params[:medical_problems], :order => 'title')
		elsif params[:sorted_by] == 'cage'
			medical_problems = MedicalProblem.find(params[:medical_problems], :order => 'title')
			medical_problems = medical_problems.sort_by{|medical_problem| [medical_problem.bat.cage ? medical_problem.bat.cage.name : '', medical_problem.bat.band]}
		elsif params[:sorted_by] == 'bat'
			medical_problems = MedicalProblem.find(params[:medical_problems], :order => 'title')
			medical_problems = medical_problems.sort_by{|medical_problem| [medical_problem.bat.band]}
		elsif params[:sorted_by] == 'date_opened'
			medical_problems = MedicalProblem.find(params[:medical_problems], :order => 'date_opened, title')
		elsif params[:sorted_by] == 'date_closed'
			medical_problems = MedicalProblem.find(params[:medical_problems], :order => 'date_closed, title')
		end
		
		render :partial=>'show_medical_problems', :locals=>{:medical_problems => medical_problems, :show_bat => params[:show_bat], 
				:list_all => params[:list_all], :div_id => params[:div_id], :sorted_by => params[:sorted_by], :show_treatments => params[:show_treatments]}
	end
	
  def show
    @medical_problem = MedicalProblem.find(params[:id])
  end

  def new
    @medical_problem = MedicalProblem.new
    @bats = Bat.find(:all, :conditions => "leave_date is null", :order => "band")
    @deactivating = false
  end

  def remote_new_medical_problem
    @users = User.find(:all, :conditions => "end_date is null and id != 1 and id != 3", :order => "name")
    render :partial=>'remote_new_medical_problem', :locals=>{:bat=>Bat.find(params[:bat])}
  end

  def remote_create
    bat = Bat.find(params[:bat])
    if params[:medical_problem][:title] == ''
      flash[:note] = 'There were problems with your submission.  Please make sure all data fields are filled out.'
			render :partial=>'show_medical_problems', :locals=>{:medical_problems => bat.medical_problems.current, :show_bat => false, 
				:list_all => false, :div_id => 'current_medical_problem', :show_treatments => true}
    else
			flash[:note] = "Medical problem was successfully created"
      @medical_problem = MedicalProblem.new(params[:medical_problem])
      @medical_problem.date_closed = nil
      @medical_problem.date_opened = Time.now
      @medical_problem.bat = bat
      @medical_problem.save
      
			if User.current_medical_care.length == 0
				flash[:note] = flash[:note] + "<warning> No current medical care users - no emails sent</warning>"
			else
				msg_body = "A medical problem has been created.\n\n"
				msg_body = msg_body + "Bat: " + @medical_problem.bat.band
				msg_body = msg_body + "\nMedical problem: " + @medical_problem.title
				msg_body = msg_body + "\nMedical problem description: " + @medical_problem.description
				msg_body = msg_body + "\nCreated by: " + User.find(session[:person]).name
				msg_body = msg_body + "\n\nFaithfully yours, etc."
				
				medical_users_emails = Array.new
				User.current_medical_care.each{|user| medical_users_emails << user.email}
				
				greeting = "Hi medical care users,\n\n"
				MyMailer.deliver_mass_mail(medical_users_emails, "medical problem created", greeting + msg_body)
			end
			
      render :partial=>'show_medical_problems', :locals=>{:medical_problems => bat.medical_problems.current, :show_bat => false, 
				:list_all => false, :div_id => 'current_medical_problem', :show_treatments => true}
    end
  end
  
  def create
    if params[:medical_problem][:title] == ''
      flash[:notice] = 'There were problems with your submission.  Please make sure all data fields are filled out.'
      redirect_to :back
    else
      @bat = Bat.find(params[:bat][:id])
      @medical_problem = MedicalProblem.new(params[:medical_problem])
      @medical_problem.date_closed = nil
      @medical_problem.bat = @bat
      if @medical_problem.save
        flash[:notice] = 'Medical problem was successfully created'
        
				if User.current_medical_care.length == 0
					flash[:notice] = flash[:notice] + "<warning> No current medical care users - no emails sent</warning>"
				else
					msg_body = "A medical problem has been created.\n\n"
					msg_body = msg_body + "Bat: " + @medical_problem.bat.band
					msg_body = msg_body + "\nMedical problem: " + @medical_problem.title
					msg_body = msg_body + "\nMedical problem description: " + @medical_problem.description
					msg_body = msg_body + "\nCreated by: " + User.find(session[:person]).name
					msg_body = msg_body + "\n\nFaithfully yours, etc."
					
					medical_users_emails = Array.new
					User.current_medical_care.each{|user| medical_users_emails << user.email}
					
					greeting = "Hi medical care users,\n\n"
					MyMailer.deliver_mass_mail(medical_users_emails, "medical problem created", greeting + msg_body)
				end
        
        redirect_to :controller => 'medical_treatments', :action => 'new', :id => @medical_problem
      else
        render :action => 'new'
      end
    end
  end

  def edit
    @bats = Bat.find(:all, :conditions => "leave_date is null", :order => "band")
    @medical_problem = MedicalProblem.find(params[:id])
    @deactivating = false
  end

  def update
    @medical_problem = MedicalProblem.find(params[:id])
    @deactivating = params[:deactivating]
    if @medical_problem.update_attributes(params[:medical_problem])
      if @deactivating
          for treatment in @medical_problem.medical_treatments.current
            treatment.end_treatment
          end
      end
      flash[:notice] = 'Medical Problem was successfully updated.'
    else
      render :action => 'edit'
    end
	  if params[:redirectme] == 'list_current'
		redirect_to :action => 'list_current'
	  else
		redirect_to :action => 'show', :id => @medical_problem
	  end
  end

  def destroy
    MedicalProblem.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def deactivate
	@medical_problem = MedicalProblem.find(params[:id])
  @bats = Bat.find(:all, :conditions => "leave_date is null", :order => "band")
  @deactivating = true
  end
  
  def reactivate
    @medical_problem = MedicalProblem.find(params[:id])
    @medical_problem.date_closed = nil
    @medical_problem.save
    redirect_to :action => :list_current
  end
end
