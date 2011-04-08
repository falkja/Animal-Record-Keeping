class TaskHistory < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
	belongs_to :weight
end