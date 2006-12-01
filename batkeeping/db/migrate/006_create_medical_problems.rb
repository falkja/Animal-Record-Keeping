class CreateMedicalProblems < ActiveRecord::Migration
  def self.up
    create_table :medical_problems do |t|
      # t.column :name, :string
    end
  end

  def self.down
    drop_table :medical_problems
  end
end
