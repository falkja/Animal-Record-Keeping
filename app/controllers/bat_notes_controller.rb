class BatNotesController < ApplicationController
  def destroy
    @bat = Bat.find(params[:id])
		BatNote.find(params[:note]).destroy
		render :partial => 'bats/display_bat_notes'
  end
end