class Training < ActiveRecord::Base
  belongs_to :training_type
  belongs_to :user
end