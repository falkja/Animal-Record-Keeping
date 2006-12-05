class CageOutHistory < ActiveRecord::Base
    belongs_to :bat
    belongs_to :cage
    belongs_to :user
    belongs_to :cage_in_history
end