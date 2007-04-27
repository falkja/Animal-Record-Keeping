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
    @user = User.new(params[:user])
    @user.end_date = nil
    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
	@deactivating = false
  end

  def deactivate
	@user = User.find(params[:id])
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
