class ChangeDateAddedRemovedToSingleDateProtocolHistories < ActiveRecord::Migration
  def self.up
    add_column :protocol_histories, :date, :datetime
    add_column :protocol_histories, :added, :boolean
    
    ProtocolHistory.update_all("added = true", "date_added is not null")
    ProtocolHistory.update_all('protocol_histories.date = protocol_histories.date_added',
      "date_added is not null")
    ProtocolHistory.update_all("added = false", "date_removed is not null")
    ProtocolHistory.update_all('protocol_histories.date = protocol_histories.date_removed',
      "date_removed is not null")
    
    remove_column :protocol_histories, :date_added
    remove_column :protocol_histories, :date_removed
  end

  def self.down
    remove_column :protocol_histories, :date_added, :datetime
    remove_column :protocol_histories, :date_removed, :datetime
    
    Rake::Task['ChangeDateAddedRemovedToMultDateProtocolHistories'].invoke
    
    remove_column :protocol_histories, :date
    remove_column :protocol_histories, :added
  end
end
