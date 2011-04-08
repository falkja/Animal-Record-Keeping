class AddDateAddedToProtocolHistories < ActiveRecord::Migration
  def self.up
    add_column :protocol_histories, :date_added, :datetime
  end

  def self.down
    remove_column :protocol_histories, :date_added
  end
end
