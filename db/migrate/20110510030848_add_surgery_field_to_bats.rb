class AddSurgeryFieldToBats < ActiveRecord::Migration
  def self.up
    add_column :bats, :surgery_time, :datetime
    add_column :bats, :surgery_note, :text
    add_column :bats, :surgery_type, :string
  end

  def self.down
    remove_column :bats, :surgery_time
    remove_column :bats, :surgery_note
    remove_column :bats, :surgery_type
  end
end
