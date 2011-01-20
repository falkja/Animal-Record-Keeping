class AddSummaryToProtocols < ActiveRecord::Migration
  def self.up
    add_column :protocols, :summary, :text
  end

  def self.down
    remove_column :protocols, :summary
  end
end
