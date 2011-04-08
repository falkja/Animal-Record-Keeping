class LeaveDateToDate < ActiveRecord::Migration
  def self.up
		change_column("bats", "leave_date", "date")
		change_column("bats", "collection_date", "date")
		change_column("cages", "date_created", "date")
		change_column("cages", "date_destroyed", "date")
		change_column("medical_problems", "date_closed", "date")
		change_column("users", "start_date", "date")
		change_column("users", "end_date", "date")
  end

  def self.down
  end
end
