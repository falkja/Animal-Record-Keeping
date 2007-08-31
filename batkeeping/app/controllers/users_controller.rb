class UsersController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @users = User.find(:all, :conditions => 'end_date is null', :order => 'name')
    @list_all = false
  end
  
  def list_all
    @users = User.find(:all, :order => 'name')
    @list_all = true
    render :action => 'list'
	end

  def show
    @user = User.find(params[:id])
  end

  def new
    @part_user_data = User.new 
    @user = User.new
    @deactivating = false
  end

  def create
    if (params[:user][:name] == '') || (params[:user][:initials] == '') || (params[:user][:email] == '')
			flash[:notice] = 'There were problems with your submission.  Please make sure all data fields are filled out.'
			redirect_to :back
    elsif User.find(:first, :conditions => "name = '#{params[:user][:name]}'")
      flash[:notice] = 'There is already a user with the same name.  Please choose a different name.'
			redirect_to :back
    elsif User.find(:first, :conditions => "initials = '#{params[:user][:initials]}'")
      flash[:notice] = 'There is already a user with the same initials.  Please choose different initials.'
			redirect_to :back
    else
      @user = User.new(params[:user])
      		@user.job_type = ''
      if params[:medical][:checked] == '1'
        @user.job_type = "Medical Care"
      end
      if params[:animal][:checked] == '1'
        @user.job_type = @user.job_type + ' ' + "Animal Care"
      end
      if params[:weekend][:checked] == '1'
        @user.job_type = @user.job_type + ' ' + "Weekend Care"
      end
      if params[:administrator][:checked] == '1'
        @user.job_type = @user.job_type + ' ' + "Administrator"
      end
      @user.end_date = nil
      if @user.save
        flash[:notice] = 'User was successfully created.'
        redirect_to :action => 'list'
      else
        render :action => 'new'
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    @deactivating = false
  end

  def deactivate
	@user = User.find(params[:id])
	
	if @user.cages.active.length > 0
		flash[:notice] = 'Deactivation failed.  User still owns cages.'
		redirect_to :controller=> 'main', :action => 'user_summary_page', :id => @user
	elsif @user.tasks.current.length > 0
		flash[:notice] = 'Deactivation failed.  User still has tasks.'
		redirect_to :controller=> 'main', :action => 'user_summary_page', :id => @user
  elsif @user.job_type != ''
    flash[:notice] = 'Deactivation failed.  User still has jobs.'
		redirect_to :controller=> 'users', :action => 'edit', :id => @user
	end
	
	@deactivating = true
  end
  
  def reactivate
	@user = User.find(params[:id])
	@user.end_date = nil	
	@user.save
	redirect_to :action => 'list'
  end
  
  def update
    @user = User.find(params[:id])
		
		@user.job_type = ''
    if params[:medical][:checked] == '1'
      @user.job_type = "Medical Care"
    end
    if params[:animal][:checked] == '1'
      @user.job_type = @user.job_type + ' ' + "Animal Care"
    end
    if params[:weekend][:checked] == '1'
      @user.job_type = @user.job_type + ' ' + "Weekend Care"
    end
    if params[:administrator][:checked] == '1'
      @user.job_type = @user.job_type + ' ' + "Administrator"
    end
    
		if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
	  if params[:redirectme] == 'list'
	    redirect_to :action => 'list'
	  else
        redirect_to :action => 'show', :id => @user
	  end
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
