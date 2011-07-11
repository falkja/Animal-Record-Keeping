class AddReminderEmailBooleansToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :wants_reminder_emails_flights, :boolean, :default => true
    add_column :users, :wants_reminder_emails_weights, :boolean, :default => true
    add_column :users, :got_reminder_email_flights, :boolean, :default => false
  end

  def self.down
    remove_column :users, :wants_reminder_emails_flights
    remove_column :users, :wants_reminder_emails_weights
    remove_column :users, :got_reminder_email_flights
  end
end
