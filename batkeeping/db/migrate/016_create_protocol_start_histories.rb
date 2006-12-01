class CreateProtocolStartHistories < ActiveRecord::Migration
  def self.up
    create_table :protocol_start_histories do |t|
      # t.column :name, :string
    end
  end

  def self.down
    drop_table :protocol_start_histories
  end
end
