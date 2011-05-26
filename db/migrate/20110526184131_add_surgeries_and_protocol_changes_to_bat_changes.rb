class AddSurgeriesAndProtocolChangesToBatChanges < ActiveRecord::Migration
  def self.up
    add_column :bat_changes, :surgery_id, :integer, :default => nil
    add_column :bat_changes, :protocol_history_id, :integer, :default => nil
    add_column :protocol_histories, :user_id, :integer, :default => nil
    
    #migrate surgeries to bat changes (not important - no surgeries in live database)
    for surgery in Surgery.all
      bat_change = BatChange.new
      bat_change.surgery = surgery
      bat_change.date = surgery.time.to_date
      bat_change.bat = surgery.bat
      bat_change.note = surgery.note
      bat_change.user = surgery.user
      bat_change.save
    end
    
    for p_hist in ProtocolHistory.all
      #migrate users to protocol_histories (take the bat's cage owner - best we can do?)
      p_hist.user = ((p_hist.bat).in_cage_when(p_hist.date.to_date)).user
      p_hist.save
    end
  end

  def self.down
    remove_column :bat_changes, :surgery_id
    remove_column :bat_changes, :protocol_history_id
    remove_column :protocol_histories, :user_id
  end
end
