class AddPreLimitWarningNumberToAllowedBats < ActiveRecord::Migration
  def self.up
    add_column :allowed_bats, :warning_limit, :integer, :default => 0
    
    AllowedBat.update_all('allowed_bats.warning_limit = allowed_bats.number')
  end

  def self.down
    remove_column :allowed_bats, :warning_limit
  end
end
