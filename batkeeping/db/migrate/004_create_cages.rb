class CreateCages < ActiveRecord::Migration
  def self.up
    create_table :cages do |t|
      # t.column :name, :string
    end
  end

  def self.down
    drop_table :cages
  end
end
