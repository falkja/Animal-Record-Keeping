class RemoveHusbandryFromProtocols < ActiveRecord::Migration
  def self.up
    remove_column :protocols, :husbandry
  end

  def self.down
    add_column :protocols, :husbandry, :boolean
  end
end
