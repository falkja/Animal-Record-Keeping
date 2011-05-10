class AddSurgeryFieldToBats < ActiveRecord::Migration
  def self.up
    add_column :bats, :surgery_time, :datetime
    add_column :bats, :surgery_note, :text
  end

  def self.down
    remove_column :bats, :surgery_time
  end
end
