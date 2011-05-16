class ChangeDateAddedRemovedToSingleDateProtocolHistories < ActiveRecord::Migration
  def self.up
    add_column :protocol_histories, :date, :datetime
    add_column :protocol_histories, :added, :boolean
    
    Rake::Task['ChangeDateAddedRemovedToSingleDateProtocolHistories'].invoke
    
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
