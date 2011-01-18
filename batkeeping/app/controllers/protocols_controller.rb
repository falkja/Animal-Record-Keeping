class ProtocolsController < ApplicationController
  # GET /protocols
  # GET /protocols.xml
  def index
    @protocols = Protocol.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @protocols }
    end
  end

  # GET /protocols/1
  # GET /protocols/1.xml
  def show
    @protocol = Protocol.find(params[:id])
	
    @past_bats, @hists = @protocol.past_bats
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @protocol }
    end
  end

  # GET /protocols/new
  # GET /protocols/new.xml
  def new
    @protocol = Protocol.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @protocol }
    end
  end

  # GET /protocols/1/edit
  def edit
    @protocol = Protocol.find(params[:id])
  end

  # POST /protocols
  # POST /protocols.xml
  def create
    @protocol = Protocol.new(params[:protocol])
    @protocol.end_date = Date.civil(params[:protocol]["start_date(1i)"].to_i, params[:protocol]["start_date(2i)"].to_i, params[:protocol]["start_date(3i)"].to_i) + 3.years
    respond_to do |format|
      if @protocol.save
        set_users_protocol(@protocol)
        format.html { redirect_to(@protocol, :notice => 'Protocol was successfully created.') }
        format.xml  { render :xml => @protocol, :status => :created, :location => @protocol }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @protocol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /protocols/1
  # PUT /protocols/1.xml
  def update
    @protocol = Protocol.find(params[:id])
    @protocol.end_date = Date.civil(params[:protocol]["start_date(1i)"].to_i, params[:protocol]["start_date(2i)"].to_i, params[:protocol]["start_date(3i)"].to_i) + 3.years
    respond_to do |format|
      if @protocol.update_attributes(params[:protocol])
        set_users_protocol(@protocol)
        format.html { redirect_to(@protocol, :notice => 'Protocol was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @protocol.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /protocols/1
  # DELETE /protocols/1.xml
  def destroy
    @protocol = Protocol.find(params[:id])
    @protocol.destroy

    respond_to do |format|
      format.html { redirect_to(protocols_url) }
      format.xml  { head :ok }
    end
  end
  
  def update_mult_bats
    @cages=Cage.active
    @rooms = Room.find(:all)
    @bats = Bat.active
    @protocols = Protocol.current
    @act = params[:act]
    render :action => :mult_bats_form
  end
  
  def change_bat_list
    @protocols = Protocol.current
    @act = params[:act]
    if params[:cage] && params[:cage][:id] != ""
      @bats = Cage.find(params[:cage][:id]).bats
    elsif params[:room] && params[:room][:id] != ""
      @bats = Room.find(params[:room][:id]).bats
    elsif params[:protocol] && params[:protocol][:id] != ""
      @bats = Protocol.find(params[:protocol][:id]).bats
    elsif params[:bats]
      @bats = Bat.find(params[:bats], :order => 'band')
    else
      @bats = [];
    end
    render :partial => 'form_bats_protocols',
      :locals => {:bats => @bats, :protocols => @protocols, :act => @act}
  end
  
  def create_mult_prots_mult_bats
    bats = Array.new
    if params[:bat_id]
      params[:bat_id].each{|id, checked| checked=='1' ? bats << Bat.find(id) : '' }
    end
    protocols = Array.new
    params[:bat_protocol_id].each{|id, checked| checked=='1' ? protocols << Protocol.find(id) : ''}
    if protocols.length > 0
      for bat in bats
        if params[:act]=='add'
          b_prot = (bat.protocols + protocols).uniq
        else
          b_prot = (bat.protocols - protocols).uniq
        end
        bat.save_protocols(b_prot,Time.now)
      end
      flash[:notice] = 'Bats/Protocols updated'
      redirect_to :action=> :index
    else
      flash[:notice] = 'No protocols selected'
      redirect_to :back
    end
	
  end
  
  def list_bats_dates
    @start_date = Date.civil(params[:post][:"start_date(1i)"].to_i,params[:post][:"start_date(2i)"].to_i,params[:post][:"start_date(3i)"].to_i)
    @end_date = (Date.civil(params[:post][:"end_date(1i)"].to_i,params[:post][:"end_date(2i)"].to_i,params[:post][:"end_date(3i)"].to_i) >> 1) - 1.day
	
    @protocol = Protocol.find(params[:id])
	
    if @start_date > @end_date
      flash[:notice] = 'Dates do not overlap'
      redirect_to :action => :show, :id => @protocol
    else
      @p_hist = @protocol.find_hist_btw(@start_date,@end_date)
    end
	
  end

  def edit_users_on_protocol
    @users = User.current
    @protocol = Protocol.find(params[:id])
  end

  def set_users_protocol(protocol)
    users = Array.new
    params[:user_id].each{|id, checked| checked=='1' ? users << User.find(id) : ''}
    protocol.users = users
  end

  def update_users_on_protocol
    protocol = Protocol.find(params[:id])
    set_users_protocol(protocol)
    redirect_to :controller => :protocols, :action => :show, :id => protocol
  end


  def edit_protocols_on_user
    @user = User.find(params[:id])
    @protocols = Protocol.current
  end

  def update_protocols_on_user
    user = User.find(params[:id])
    protocols = Array.new
    params[:protocol_id].each{|id, checked| checked=='1' ? protocols << Protocol.find(id) : ''}
    user.protocols = protocols
    redirect_to :controller => :users, :action => :show, :id => user
  end
end
