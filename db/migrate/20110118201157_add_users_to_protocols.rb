class AddUsersToProtocols < ActiveRecord::Migration
  def self.up
    create_table :protocols_users, :id => false do |t|
      t.integer :protocol_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :protocols_users
  end
end
