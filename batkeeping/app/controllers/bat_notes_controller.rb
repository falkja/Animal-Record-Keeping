class BatNotesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @bat_note_pages, @bat_notes = paginate :bat_notes, :per_page => 10
  end

  def show
    @bat_note = BatNote.find(params[:id])
  end

  def new
    @bat_note = BatNote.new
  end

  def create
    @bat_note = BatNote.new(params[:bat_note])
    if @bat_note.save
      flash[:notice] = 'BatNote was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @bat_note = BatNote.find(params[:id])
  end

  def update
    @bat_note = BatNote.find(params[:id])
    if @bat_note.update_attributes(params[:bat_note])
      flash[:notice] = 'BatNote was successfully updated.'
      redirect_to :action => 'show', :id => @bat_note
    else
      render :action => 'edit'
    end
  end

  def destroy
    BatNote.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
