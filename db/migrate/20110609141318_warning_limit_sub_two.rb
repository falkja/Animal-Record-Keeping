class WarningLimitSubTwo < ActiveRecord::Migration
  def self.up
    #changing the warning limit to be two less than the allowed bats number (unless the number is less than 2, which would put it at a negative value)
    AllowedBat.update_all('allowed_bats.warning_limit = (allowed_bats.number - 2)', 
    'number > 2')
  end

  def self.down
    AllowedBat.update_all('allowed_bats.warning_limit = allowed_bats.number')
  end
end
