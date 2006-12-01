class CreateProposedTreatments < ActiveRecord::Migration
  def self.up
    create_table :proposed_treatments do |t|
      # t.column :name, :string
    end
  end

  def self.down
    drop_table :proposed_treatments
  end
end
