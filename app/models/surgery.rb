class Surgery < ActiveRecord::Base
  belongs_to :bat
  belongs_to :surgery_type
  belongs_to :user
end