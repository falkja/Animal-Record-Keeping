class CreateProposedHistories < ActiveRecord::Migration
  def self.up
    create_table :proposed_histories do |t|
      # t.column :name, :string
    end
  end

  def self.down
    drop_table :proposed_histories
  end
end
