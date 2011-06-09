class ProtocolsController < ApplicationController
  # GET /protocols
  # GET /protocols.xml
  def index
    if params[:ids]
      @protocols = Protocol.find(params[:ids],:order => 'number')
    else
      @protocols = Protocol.all(:order => 'number')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @protocols }
    end
  end

  # GET /protocols/1
  # GET /protocols/1.xml
  def show
    @protocol = Protocol.find(params[:id])
    @past_bats = @protocol.all_past_bats - @protocol.bats
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @protocol }
    end
  end

  # GET /protocols/new
  # GET /protocols/new.xml
  def new
    @protocol = Protocol.new
    @protocol.build_allowed_bats
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
        set_many_to_many_relationships(@protocol)
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
        set_many_to_many_relationships(@protocol)
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
    @cages=Cage.has_bats
    @rooms = Room.has_bats
    @bats = User.find(session[:person]).bats
    @protocols = Protocol.has_bats
    @act = params[:act]
    render :action => :mult_bats_form
  end
  
  def change_bat_list
    @protocols = Protocol.has_bats
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
      :locals => {:bats => @bats, :protocols => @protocols, :act => @act,
      :cages => Cage.has_bats, :rooms => Room.has_bats}
  end
  
  def create_mult_prots_mult_bats
    bats = Array.new
    if params[:bat_id]
      params[:bat_id].each{|id, checked| checked=='1' ? bats << Bat.find(id) : '' }
    end
    protocols = Array.new
    if params[:protocol_id]
      params[:protocol_id].each{|id, checked| checked=='1' ? protocols << Protocol.find(id) : ''}
    end
    if protocols.length > 0 and bats.length > 0

      #check to make sure # bats isn't over the limit of what's allowed
      if params[:act]=='add'
        for p in protocols
          if p.check_allowed_bats(bats) == false
            flash[:notice] = 'Over the allowed bats limit'
            redirect_to :action => :edit, :id => p and return
          end
        end
      end

      for bat in bats
        if params[:act]=='add'
          b_prot = (bat.protocols + protocols).uniq
        else
          b_prot = (bat.protocols - protocols).uniq
        end
        bat.save_protocols(b_prot,Time.now,User.find(session[:person]))
      end
      flash[:notice] = 'Bats/Protocols updated'
      redirect_to :action=> :index
    else
      flash[:notice] = 'No protocols or bats selected'
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

  def list_bats_active_between
    @start_date = Date.civil(params[:post][:"start_date(1i)"].to_i,params[:post][:"start_date(2i)"].to_i,params[:post][:"start_date(3i)"].to_i)
    #we >> 1 to increase the date by one month and we subtract one day from the end date because we want the last day of the month
    @end_date = (Date.civil(params[:post][:"end_date(1i)"].to_i,params[:post][:"end_date(2i)"].to_i,params[:post][:"end_date(3i)"].to_i) >> 1) - 1.day

    @protocol = Protocol.find(params[:id])

    if @start_date > @end_date
      flash[:notice] = 'Dates do not overlap'
      redirect_to :action => :show, :id => @protocol
    else
      @bats = @protocol.find_active_btw(@start_date,@end_date)
    end
  end

  def edit_users_on_protocol
    @users = User.current
    @protocol = Protocol.find(params[:id])
  end

  def set_many_to_many_relationships(protocol)
    set_users_protocol(protocol)
    set_data_protocol(protocol)
    set_surgery_types_protocol(protocol)
  end
  
  def set_users_protocol(protocol)
    users = Array.new
    params[:user_id].each{|id, checked| checked=='1' ? users << User.find(id) : ''}
    protocol.users = users
  end
  
  def set_data_protocol(protocol)
    data = Array.new
    params[:datum_id] ? params[:datum_id].each{|id, checked| checked=='1' ? data << Datum.find(id) : ''} : ''
    protocol.data = data
  end
  
  def set_surgery_types_protocol(protocol)
    surgery_types = Array.new
    params[:surgery_type_id] ? 
      params[:surgery_type_id].each{|id, checked| checked=='1' ? surgery_types << SurgeryType.find(id) : ''} : ''
    protocol.surgery_types = surgery_types
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
  
  def remote_add_data
    if params[:prot] && params[:prot] != ''
      protocol = Protocol.find(params[:prot])
    else
      protocol = nil
    end
    
    d = Datum.new
    d.name = params[:name]
    d.save
    
    render :partial => "data_on_protocol_form", :locals => {:protocol => protocol,
      :data => Datum.all}
  end
  
  def delete_data
    if params[:prot] && params[:prot] != ''
      protocol = Protocol.find(params[:prot])
    else
      protocol = nil
    end
    
    d = Datum.find(params[:data])
    
    if d.protocols.length > 0
      flash.now[:data_notice]='Data associated with a protocol, cannot delete'
    else
      d.destroy
    end
    
    render :partial => "data_on_protocol_form", :locals => {:protocol => protocol,
      :data => Datum.all}
  end
  
  def remote_add_surgery_type
    if params[:prot] && params[:prot] != ''
      protocol = Protocol.find(params[:prot])
    else
      protocol = nil
    end
    
    sg_t = SurgeryType.new
    sg_t.name = params[:name]
    sg_t.save
    
    flash.now[:surgery_notice]=
        'Surgery type created'
    
    render :partial => "surgeries_on_protocol_form", :locals => 
      {:protocol => protocol, :surgery_types => SurgeryType.all}
  end
  
  def delete_surgery_type
    if params[:prot] && params[:prot] != ''
      protocol = Protocol.find(params[:prot])
    else
      protocol = nil
    end
    
    sg_t = SurgeryType.find(params[:surgery_type])
    
    if !sg_t.protocols.empty? || !sg_t.surgeries.empty?
      flash.now[:surgery_notice]=
        'Surgery type associated with a protocol or surgeries, cannot delete'
    else
      sg_t.destroy
    end
    
    render :partial => "surgeries_on_protocol_form", :locals => 
      {:protocol => protocol, :surgery_types => SurgeryType.all}
  end
  
  def show_summary_in_table
    protocol = Protocol.find(params[:prot])
    if params[:limit] == "3"
      limit = protocol.summary.split("\n").length
    else
      limit = 3
    end
    render :partial => "show_summary_in_table", 
      :locals => {:protocol=>protocol, :limit=> limit}
  end
  
  def edit_warning_limit
    number = params[:number].to_i
    limit = [number - 2,0].max
    render :partial => "edit_warning_limit", :locals=>{:attribute_number=>params[:attribute_number],:limit_value=>limit}
  end
end
