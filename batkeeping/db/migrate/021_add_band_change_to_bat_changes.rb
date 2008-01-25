class AddBandChangeToBatChanges < ActiveRecord::Migration
  def self.up
		add_column :bat_changes, :old_band_name, :string
		add_column :bat_changes, :new_band_name, :string
  end

  def self.down
		remove_column :bat_changes, :old_band_name
		remove_column :bat_changes, :new_band_name
  end
end
