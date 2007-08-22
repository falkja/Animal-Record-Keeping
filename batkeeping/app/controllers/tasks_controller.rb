class TasksController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @general_tasks_today = Task.general_tasks_today
	  @weighing_tasks_today = Task.weighing_tasks_today
	  @feeding_tasks_today = Task.feeding_tasks_today
	  @medical_tasks_today = Task.medical_tasks_today
	  @general_tasks_not_today = Task.general_tasks_not_today
	  @weighing_tasks_not_today = Task.weighing_tasks_not_today
	  @feeding_tasks_not_today = Task.feeding_tasks_not_today
	  @medical_tasks_not_today = Task.medical_tasks_not_today
    @general_tasks = Task.general_tasks
    @weighing_tasks = Task.weighing_tasks
    @feeding_tasks = Task.feeding_tasks
    @medical_tasks = Task.medical_tasks
    
    @feeding_cages = Cage.has_feeding_tasks
    @cages = Cage.has_bats
    @medical_problems = MedicalProblem.current
  end
  
  def hide_tasks
		show_hide_tasks
		
	  render :partial => 'hide_tasks', :locals => {:general_tasks => @general_tasks, :weighing_tasks => @weighing_tasks, 
                  :feeding_tasks => @feeding_tasks, :user => @user, :source => params[:source],
									:medical_tasks => @medical_tasks, :div_id => params[:div_id], :feeding_cages => @feeding_cages,
									:cages => @cages, :medical_problems => @medical_problems, :same_type_task_list => params[:same_type_task_list],
									:sorted_by => params[:sorted_by]}
  end
  
  def show_tasks
    show_hide_tasks
		
	  render :partial => 'show_tasks', :locals => {:general_tasks => @general_tasks, :weighing_tasks => @weighing_tasks, 
                  :feeding_tasks => @feeding_tasks, :user => @user, :source => params[:source],
									:medical_tasks => @medical_tasks, :div_id => params[:div_id], :feeding_cages => @feeding_cages,
									:cages => @cages, :medical_problems => @medical_problems, :same_type_task_list => params[:same_type_task_list],
									:sorted_by => params[:sorted_by]}
  end

  def show_hide_tasks
    if params[:user]
      @user = User.find(params[:user])
    else
      @user = User.find(session[:person])
    end
    
    params[:medical_tasks] ? @medical_tasks = Task.find(params[:medical_tasks]) : @medical_tasks = Array.new
    params[:general_tasks] ? @general_tasks = Task.find(params[:general_tasks]) : @general_tasks = Array.new
    
    if (params[:source].include? 'user_summary') && (params[:div_id].include? 'todays_tasks')
      @weighing_tasks = @user.tasks.weighing_tasks_today
      @feeding_tasks = @user.tasks.feeding_tasks_today
      
      if (@user.animal_care_user? || @user.weekend_care_user?)
        Task.animal_care_user_weighing_tasks_today.each{|task| @weighing_tasks << task}
        Task.animal_care_user_feeding_tasks_today.each{|task| @feeding_tasks << task}
      end
    elsif (params[:source].include? 'user_summary') && (params[:div_id].include? 'other_tasks')
      @weighing_tasks = @user.tasks.weighing_tasks_not_today
      @feeding_tasks = @user.tasks.feeding_tasks_not_today
      
      if (@user.animal_care_user? || @user.weekend_care_user?)
        Task.animal_care_user_weighing_tasks_not_today.each{|task| @weighing_tasks << task}
        Task.animal_care_user_feeding_tasks_not_today.each{|task| @feeding_tasks << task}
      end
    elsif (params[:source].include? 'user_summary') && (params[:div_id].include? 'all_tasks')
      @weighing_tasks = @user.tasks.weighing_tasks
      @feeding_tasks = @user.tasks.feeding_tasks
      
      if (@user.animal_care_user? || @user.weekend_care_user?)
        Task.animal_care_user_weighing_tasks.each{|task| @weighing_tasks << task}
        Task.animal_care_user_feeding_tasks.each{|task| @feeding_tasks << task}
      end
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'todays_tasks')
      @weighing_tasks = Task.weighing_tasks_today
      @feeding_tasks = Task.feeding_tasks_today
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'other_tasks')
      @weighing_tasks = Task.weighing_tasks_not_today
      @feeding_tasks = Task.feeding_tasks_not_today
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'all_tasks')
      @weighing_tasks = Task.weighing_tasks
      @feeding_tasks = Task.feeding_tasks
    end
		
		@feeding_tasks = @feeding_tasks.sort_by{|task| [task.repeat_code, task.title]}
		@weighing_tasks = @weighing_tasks.sort_by{|task| [task.repeat_code, task.title]}
		
		params[:feeding_cages] ? @feeding_cages = Cage.find(params[:feeding_cages]) : @feeding_cages = Array.new
		params[:medical_problems] ? @medical_problems = MedicalProblem.find(params[:medical_problems]) : @medical_problems = Array.new
		params[:cages] ? @cages = Cage.find(params[:cages]) : @cages = Array.new
  end

  def sort_by
    if params[:sorted_by] == 'room'
			tasks = Task.find(params[:tasks], :order => 'title, repeat_code')
			tasks = tasks.sort_by{|task| [task.room_id ? task.room.name : '']}
		elsif params[:sorted_by] == 'repeat_code'
			tasks = Task.find(params[:tasks], :order => 'title')
			tasks = tasks.sort_by{|task| [task.repeat_code, task.medical_treatment ? task.medical_treatment.medical_problem.bat.band : '']}
    elsif params[:sorted_by] == 'bat'
      tasks = Task.find(params[:tasks], :order => 'title, repeat_code')
      tasks = tasks.sort_by{|task|[task.medical_treatment.medical_problem.bat.band, task.repeat_code]}
    elsif params[:sorted_by] == 'medical_problem'
      tasks = Task.find(params[:tasks], :order => 'title, repeat_code')
      tasks = tasks.sort_by{|task|[task.medical_treatment.medical_problem.title]}
    elsif params[:sorted_by] == 'cage'
      tasks = Task.find(params[:tasks], :order => 'title, repeat_code')
      tasks = tasks.sort_by{|task|[task.medical_treatment.medical_problem.bat.cage.name]}
		elsif params[:sorted_by] == 'title' #title
			tasks = Task.find(params[:tasks], :order => 'title, repeat_code')
		end
		
    render :partial => 'tasks_list', :locals => {:tasks => tasks, 
      :div_id => params[:div_id], :same_type_task_list => params[:same_type_task_list], :manage => params[:manage],
			:sorted_by => params[:sorted_by]}
  end
  
  def show
    @task = Task.find(params[:id])
    if @task.internal_description == 'weigh'
      tasks = Task.find(:all, :conditions => "internal_description = 'weigh' and cage_id = #{@task.cage.id}")
      @task_histories = Array.new
      for task in tasks
        for task_history in task.task_histories
          @task_histories << task_history
        end
      end
      @task_histories = @task_histories.sort_by{|task_history| [Time.now - task_history.date_done]}
    elsif @task.medical_treatment
      @task_histories = @task.medical_treatment.task_histories
    else
      @task_histories = @task.task_histories
    end
  end

  def choose_new_task
    @cages = Cage.has_bats
    @medical_problems = MedicalProblem.current
  end

  def new
    @task = Task.new
    @users = User.current
  end

  #called from the form on the list tasks page, needed so that the page that is requested has an ID attached to it so that refreshes of the page don't break
  def form_to_new_weigh_cage_task
    @cage = Cage.find(params[:id])
    redirect_to :action => 'new_weigh_cage_task', :id => @cage
  end

  def remote_new_weigh_cage_task
    render :partial => 'remote_new_weigh_cage_task', :locals => {:cage => Cage.find(params[:id]), :sorted_by => params[:sorted_by], 
        :div_id => params[:div_id], :source => params[:source], :user => params[:user],
        :same_type_task_list => params[:same_type_task_list], :users=>User.current, :quick_add => params[:quick_add]}
  end

  def new_weigh_cage_task
    if params[:id] == nil
      redirect_to :back
    else
      @cage = Cage.find(params[:id])
      @users = User.current
    end
  end

  def create_weigh_cage_task #called from new_weigh_cage_task page
    @cage = Cage.find(params[:id])
    
    if ( (params[:users] != nil) || (params[:task][:animal_care] == '1') ) && (params[:days] != nil) #error checking
    
    params[:users] ? @users = User.find(params[:users]) : @users = Array.new
    @days = params[:days]
    
    if @days.include?("0")  #only need one daily task
        @days.clear
        @days << "0"
    end
    
    for day in @days
      @task = Task.new
      @task.repeat_code = day
      @task.cage = @cage
			@task.room = @cage.room
      @task.title = "Weigh cage " + @cage.name    
      @task.internal_description = "weigh"
      @task.jitter = params[:task][:jitter]
      @task.date_started = Time.now
			@task.animal_care = params[:task][:animal_care]
      @task.save
			@task.users = @users
			
			task_census = TaskCensus.new
			task_census.create_task_census(@cage.room, @task)
    end
    
    flash[:note] = 'Weigh cage task(s) successfully created. If the task does not appear below, it may be for a different day or a different user.'
    
    end
    
		params[:user] ? @user = User.find(params[:user]) : ''
    
    if (params[:source].include? 'user_summary') && (params[:div_id].include? 'todays_tasks')
      weighing_tasks = @user.tasks.weighing_tasks_today
      if (@user.animal_care_user? || @user.weekend_care_user?)
        Task.animal_care_user_weighing_tasks_today.each{|task| weighing_tasks << task}
      end
    elsif (params[:source].include? 'user_summary') && (params[:div_id].include? 'other_tasks')
      weighing_tasks = @user.tasks.weighing_tasks_not_today
      if (@user.animal_care_user? || @user.weekend_care_user?)
        Task.animal_care_user_weighing_tasks_not_today.each{|task| weighing_tasks_not_today << task}
      end
    elsif (params[:source].include? 'user_summary') && (params[:div_id].include? 'all_tasks')
      weighing_tasks = @user.tasks.weighing_tasks
      if (@user.animal_care_user? || @user.weekend_care_user?)
        Task.animal_care_user_weighing_tasks.each{|task| weighing_tasks << task}
      end
    elsif params[:source] == 'show_cage'
      weighing_tasks = @cage.tasks.weighing_tasks
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'todays_tasks')
      weighing_tasks = Task.weighing_tasks_today
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'other_tasks')
      weighing_tasks = Task.weighing_tasks_not_today
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'all_tasks')
      weighing_tasks = Task.weighing_tasks
    end
    
		weighing_tasks = weighing_tasks.sort_by{|task| [task.repeat_code, task.title]}
		
    render :partial => 'tasks_list', :locals => {:tasks => weighing_tasks, :sorted_by => params[:sorted_by],
			:div_id => params[:div_id], :same_type_task_list => params[:same_type_task_list], :manage => true}
  end


  def manage_feeding_tasks
    if params[:id] == nil
      redirect_to :back
    else
      @cage = Cage.find(params[:id])
      @users = User.current
    end
  end
	  
  def update_multiple_feeding_tasks
    @cage = Cage.find(params[:id])
    if (params[:task][:food] == '') || (params[:task][:dish_num] == '')
      flash[:note] = 'There were problems with your submission.  Please make sure all data fields are filled out.'
      render :partial => 'tasks_list', :locals => {:tasks => @cage.tasks.feeding_tasks, :div_id => 'feeding_tasks', 
				:same_type_task_list => true, :manage => true, :sorted_by => params[:sorted_by]}
    else
      for task in @cage.tasks.feeding_tasks
          task.food = params[:task][:food]
          task.dish_type = params[:task][:dish_type]
          task.dish_num = params[:task][:dish_num]
          task.save
      end
      render :partial => 'tasks_list', :locals => {:tasks => @cage.tasks.feeding_tasks, :div_id => 'feeding_tasks', 
				:same_type_task_list => true, :manage => true, :sorted_by => params[:sorted_by]}
    end
  end
  
  def remote_new_feed_cage_task
    render :partial => 'remote_new_feed_cage_task', :locals => {:cage => Cage.find(params[:id]), :div_id => params[:div_id], 
        :source => params[:source], :user => params[:user], :sorted_by => params[:sorted_by],
        :same_type_task_list => params[:same_type_task_list], :users => User.current, :quick_add => params[:quick_add]}
  end

  def create_feed_cage_task #called from new_feed_cage_task page
    @cage = Cage.find(params[:id])
    if (params[:task][:dish_num] != '') && ( (params[:users] != nil) || (params[:task][:animal_care] == "1") ) && (params[:days] != nil) #error checking
      params[:users] ? @users = User.find(params[:users]) : @users = Array.new
      @days = params[:days]
      
      if @days.include?("0")  #need to convert to multiple tasks
          @days.clear
          @days = ["1","2","3","4","5","6","7"]
      end
      
      for day in @days
        @task = Task.new
        @task.repeat_code = day
        @task.cage = @cage
        @task.room = @cage.room
        @task.title = "Feed cage " + @cage.name    
        @task.internal_description = "feed"
        @task.food = params[:task][:food]
        @task.dish_type = params[:task][:dish_type]
        @task.dish_num = params[:task][:dish_num]
        @task.jitter = 0
        @task.date_started = Time.now
        @task.animal_care= params[:task][:animal_care]
        @task.save
        @task.users = @users
        
        task_census = TaskCensus.new
        task_census.create_task_census(@cage.room, @task)
      end
      
      flash[:note] = 'Feed cage task(s) successfully created. If the task does not appear below, it could be for a different day or for a different user (if on user summary page)'
      
    end
    
		params[:user] ? @user = User.find(params[:user]) : ''
		
		find_feeding_tasks
		
		@feeding_tasks = @feeding_tasks.sort_by{|task| [task.repeat_code, task.title]}
    
    render :partial => 'tasks_list', :locals => {:tasks => @feeding_tasks, :sorted_by => params[:sorted_by],
                                      :div_id => params[:div_id], :same_type_task_list => params[:same_type_task_list], :manage => true}
  end

	def find_feeding_tasks
		if (params[:source].include? 'user_summary') && (params[:div_id].include? 'todays_tasks')
      @feeding_tasks = @user.tasks.feeding_tasks_today
      if (@user.animal_care_user? || @user.weekend_care_user?)
        Task.animal_care_user_feeding_tasks_today.each{|task| @feeding_tasks << task}
      end
    elsif (params[:source].include? 'user_summary') && (params[:div_id].include? 'other_tasks')
      @feeding_tasks = @user.tasks.feeding_tasks_not_today
      if (@user.animal_care_user? || @user.weekend_care_user?)
        Task.animal_care_user_feeding_tasks_not_today.each{|task| @feeding_tasks << task}
      end
    elsif (params[:source].include? 'user_summary') && (params[:div_id].include? 'all_tasks')
      @feeding_tasks = @user.tasks.feeding_tasks
      if (@user.animal_care_user? || @user.weekend_care_user?)
        Task.animal_care_user_feeding_tasks.each{|task| @feeding_tasks << task}
      end
    elsif params[:source] == 'show_cage'
      @feeding_tasks = @cage.tasks.feeding_tasks
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'todays_tasks')
      @feeding_tasks = Task.feeding_tasks_today
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'other_tasks')
      @feeding_tasks = Task.feeding_tasks_not_today
    elsif params[:source] == 'task_list' && (params[:div_id].include? 'all_tasks')
      @feeding_tasks = Task.feeding_tasks
    end
	end

  def create_medical_task
    if ( (params[:users] != nil) || (params[:task][:animal_care] == '1') ) && (params[:days] != nil) #error checking
		
		medical_treatment = MedicalTreatment.find(params[:id])
		
		params[:users] ? users = User.find(params[:users]) : users = Array.new
    days = params[:days]
		
		if days.include?("0")  #need to convert to multiple tasks
			days.clear
			days = ["1","2","3","4","5","6","7"]
    end
		
		all_tasks_created_successfully = true
		for day in days
				task = Task.find_by_medical_treatment_id_and_repeat_code(medical_treatment, day) || Task.create(:medical_treatment => medical_treatment, :repeat_code => day, :jitter => 0, :date_started => Time.now, :title => medical_treatment.title, :internal_description => "medical")
        task.date_ended = nil
				task.animal_care = params[:task][:animal_care]
				task.save
				task.users = users
		end
		
    flash[:note] = 'All tasks created successfully.  If some tasks already existed for the day, they were overwritten.'
		
    medical_tasks = medical_treatment.tasks.current.sort_by{|task| [task.repeat_code, task.title]}
    
		render :partial => 'tasks_list', :locals => {:tasks => medical_tasks, :sorted_by => params[:sorted_by],
			:div_id => params[:div_id], :same_type_task_list => true, :manage => true}
		
		end
	end

	def do_medical_task
		if params[:id]
      @task = Task.find(params[:id])
      @medical_treatment = @task.medical_treatment
      @medical_problem = @medical_treatment.medical_problem
    else
      @medical_problem = MedicalProblem.find(params[:medical_problem])
    end
    bat = @medical_problem.bat
    bat.weights.today ? @weight = bat.weights.today : @weight = Weight.new
		@task_histories = Array.new
    @medical_problem.medical_treatments.each{|medical_treatment| medical_treatment.tasks.each{|task| task.task_histories.each{|task_history| @task_histories << task_history}}}
    @task_histories = TaskHistory.find(@task_histories, :order => "date_done desc")
    @redirectme = params[:redirectme]
    @user = params[:user]
  end
	
  def create
    (params[:users] == nil) ? @users = Array.new : @users = User.find(params[:users])
		
    @days = params[:days]
		
    if @days.include?("0")  #only need one daily task
			@days.clear
			@days << "0"
    end
    
    for day in @days
			@task = Task.new(params[:task])
			@task.repeat_code = day
			@task.date_started = Time.now
			@task.save
			@task.users = @users
			
			if params[:task][:room_id]
				task_census = TaskCensus.new
				task_census.create_task_census(@task.room, @task)
			end
    end
    redirect_to :action => 'list'
  end

  def edit
    @task = Task.find(params[:id])
    @users = User.current
    @user_ids = Array.new 
    @task.users.each {|user| @user_ids << user.id }
    @editing = true
		@rooms = Room.find(:all, :order => "name")
  end

  def update
    @task = Task.find(params[:id])
		old_room = Room.find(@task.room_id)
		old_repeat_code = @task.repeat_code
		
    if @task.update_attributes(params[:task])
      params[:users] ? @task.users = User.find(params[:users]) : @task.users = Array.new
			
			if (old_room != @task.room)
				TaskCensus.room_swap(@task.room, @task)
			end
			
			if (old_repeat_code != @task.repeat_code)
				task_census = TaskCensus.find(:first, :conditions => "task_id = #{@task.id} and date = '#{Time.now.strftime("%Y-%m-%d")}'")
				task_census ? task_census.destroy : ''
				
				tday = Time.now.wday + 1
				if (@task.repeat_code == tday) || (@task.repeat_code == 0)
					task_census = TaskCensus.new
					task_census.create_task_census(@task.room, @task)
				end
			end
			
      flash[:notice] = 'Task was successfully updated'
      redirect_to :action => 'list'
    else
      render :action => 'edit'
    end
  end

  def done
		task = Task.find(params[:id])
    Task::set_current_user(User.find(session[:person]))
    task.done
		params[:tasks] = params[:ids]
		flash[:note] = "Task was successfully updated"
		sort_by
  end
  
  def medical_task_done
    if !params[:treatments_done].has_value?('1') && !params[:one_time_treatment].has_value?('1')
      flash[:notice] = "No treatments selected as done"
      redirect_to :back
      
    elsif params[:one_time_treatment].has_value?('1') && (params[:new_task][:title] == 'one time treatment' || params[:new_task][:title]  == '')
      flash[:notice] = "Please enter a title for your one time treatment"
      redirect_to :back
      
    elsif params[:one_time_treatment].has_value?('0') && (params[:new_task][:title] != 'one time treatment' && params[:new_task][:title] != '')
      flash[:notice] = "Please click the checkbox next to your one time treatment"
      redirect_to :back
      
    else
      
      bat = MedicalProblem.find(params[:medical_problem]).bat
      
      tasks = Array.new
      params[:treatments_done].each{|key, value| if (value == '1') then tasks << MedicalTreatment.find(key).todays_task end }
      
      if params[:one_time_treatment].has_value?('1') && (params[:new_task][:title] != 'one time treatment' && params[:new_task][:title] != '')
        one_time_treatment = MedicalTreatment.new
        one_time_treatment.title = params[:new_task][:title]
        one_time_treatment.medical_problem = MedicalProblem.find(params[:medical_problem])
        one_time_treatment.date_opened = Date.today
        one_time_treatment.date_closed = Date.today
        one_time_treatment.save
        
        one_time_task = Task.new
        one_time_task.repeat_code = nil
        one_time_task.medical_treatment = one_time_treatment
        one_time_task.title = one_time_treatment.title
        one_time_task.date_started = Time.now
        one_time_task.date_ended = Time.now
        one_time_task.animal_care = 0
        one_time_task.internal_description = "medical"
        one_time_task.jitter = 0
        one_time_task.save
        
        users = Array.new
        users << User.find(session[:person])
        one_time_task.users = users
        tasks << one_time_task
      end
      
      if params[:weight][:weight] != ''
        
        cage = bat.cage
        
        if params[:weight][:new_weight]
          weight = Weight.new
        else
          bat.weights.today ? weight = bat.weights.today : weight = Weight.new
        end
        
        weight.bat = bat
        weight.date = Time.gm(params[:task_history]["date_done(1i)"], params[:task_history]["date_done(2i)"], params[:task_history]["date_done(3i)"], params[:task_history]["date_done(4i)"], params[:task_history]["date_done(5i)"], nil)
        weight.user = User.find(session[:person])
        weight.weight = params[:weight][:weight]
        weight.note = params[:weight][:note]
        if params[:checkbox][:after_eating] == '1'
          weight.after_eating = 'y'
        else
          weight.after_eating =  'n'
        end
        weight.save
        
        Task::set_current_user(User.find(session[:person]))
        cage.update_weighing_tasks
        
      end
      
      for task in tasks
        task_history = TaskHistory.new(params[:task_history])
        task_history.user = User.find(session[:person])
        task_history.task = task
        weight ? task_history.weight = weight : ''
        task_history.save
      end
      
      if params[:redirectme] == 'user_summary_page'
        redirect_to :controller => 'main', :action => 'user_summary_page', :id => User.find(params[:user])
      elsif params[:redirectme] == 'show_bat'
        redirect_to :controller => 'bats', :action => 'show', :id => bat
      elsif params[:redirectme] == 'weigh_bat'
        redirect_to :controller => 'bats', :action => 'weigh_bat', :id => bat
      else
        redirect_to :controller => 'medical_problems', :action => 'list_current'
      end
    
    end
  end
  
  def destroy
    tasks = Task.find(params[:ids])
    tasks.delete(Task.find(params[:id]))
    Task.find(params[:id]).deactivate
		
		params[:tasks] = params[:ids]
		
    flash[:note] = "Task destroyed"
    
    sort_by
  end
  
  def destroy_medical_task
    Task.find(params[:id]).deactivate
    redirect_to :controller => 'medical_problems', :action => 'list'
  end
  
  def clear_tasks
    tasks = Task.find(params[:tasks])
    for task in tasks
	    task.date_ended = Time.now
      task.save
    end
    render :partial => 'tasks_list', :locals => {:tasks => [], :div_id => params[:div_id], :same_type_task_list => params[:same_type_task_list], :manage => params[:manage]}
  end
	
  def done_tasks
		params[:user] ? @user = User.find(params[:user]) : ''
		find_feeding_tasks
		Task::set_current_user(User.find(session[:person]))
    for task in @feeding_tasks
			task.done
    end
    flash[:note] = "All feeding tasks marked done"
    render :partial => 'tasks_list', :locals => {:tasks => @feeding_tasks, :div_id => params[:div_id], :same_type_task_list => params[:same_type_task_list], :manage => params[:manage]}
  end
	
	def show_hide_task_categories
		params[:tasks] ? tasks = Task.find(params[:tasks], :order => 'repeat_code, title') : tasks = Array.new
		params[:medical_problems] ? medical_problems = MedicalProblem.find(params[:medical_problems]) : medical_problems = Array.new
		params[:cages] ? cages = Cage.find(params[:cages]) : cages = Array.new
		render :partial => 'show_hide_task_category', :locals => {:tasks => tasks, :div_id => params[:div_id],
				:same_type_task_list => params[:same_type_task_list], :manage => params[:manage], :cages => cages,
				:source => params[:source], :count => params[:count], :show => params[:show], :category_div => params[:category_div],
				:medical_problems => medical_problems, :sorted_by => params[:sorted_by]}
	end
	
  def show_hide_users
    users = User.current
    if params[:task]
      task = Task.find(params[:task])
      user_ids = Array.new
      task.users.each {|user| user_ids << user.id }
    end
    (params[:show_users] == "1") ? show_users = false : show_users = true
    render :partial => 'users_for_tasks', 
				:locals=>{:show_users => show_users, :users => users, :user_ids => user_ids, 
				:quick_add => params[:quick_add], :show_medical => params[:show_medical], 
				:div_id => params[:div_id]}
  end
  
	
	def show_hide_rooms
		@rooms = Room.find(:all, :order => "name")
		(params[:switch_room] == "1") ?	show_rooms = true : show_rooms = false
		
		params[:task] ? @task = Task.find(params[:task]) : ''
		
		render :partial => 'rooms_for_tasks', :locals=>{:show_rooms => show_rooms}
	end
	
	def edit_task_history
		@task_history = TaskHistory.find(params[:id])
		@redirect_me = params[:redirect_me]
	end
	
	def update_task_history
		task_history = TaskHistory.find(params[:id])
		task_history.remarks = params[:task_history][:remarks]
		task_history.save
		
		if params[:redirect_me] == 'do_medical_task'
			redirect_to :action => 'do_medical_task', :id => task_history.task
		elsif params[:redirect_me] == 'show_task'
			redirect_to :action => 'show', :id => task_history.task
		elsif params[:redirect_me] == 'show_treatment'
			redirect_to :controller => 'medical_treatments', :action => 'show', :id => task_history.task.medical_treatment
		end
	end
	
end