class CreateMedicalCareActions < ActiveRecord::Migration
  def self.up
    create_table :medical_care_actions do |t|
      # t.column :name, :string
    end
  end

  def self.down
    drop_table :medical_care_actions
  end
end
