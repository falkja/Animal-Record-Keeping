class CageInHistory < ActiveRecord::Base
    belongs_to :bat
    belongs_to :cage
    belongs_to :user
    has_one :cage_out_history
end