class CreateBatNotes < ActiveRecord::Migration
  def self.up
    create_table :bat_notes do |t|
      # t.column :name, :string
    end
  end

  def self.down
    drop_table :bat_notes
  end
end
