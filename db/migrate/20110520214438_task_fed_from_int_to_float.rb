class TaskFedFromIntToFloat < ActiveRecord::Migration
  def self.up
    change_column(:task_histories, :fed, :double, :default => nil)
  end

  def self.down
    change_column(:task_histories, :fed, :int, :default => nil)
  end
end
