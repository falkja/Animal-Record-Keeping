class AddVaccinationEmailSentToBats < ActiveRecord::Migration
  def self.up
    add_column :bats, :vaccination_email_sent, :boolean, :default => false
  end

  def self.down
    remove_column :bats, :vaccination_email_sent
  end
end
