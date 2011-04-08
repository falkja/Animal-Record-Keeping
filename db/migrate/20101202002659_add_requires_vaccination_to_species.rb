class AddRequiresVaccinationToSpecies < ActiveRecord::Migration
  def self.up
    add_column :species, :requires_vaccination, :boolean, :default => 0
  end

  def self.down
    remove_column :species, :requires_vaccination
  end
end
