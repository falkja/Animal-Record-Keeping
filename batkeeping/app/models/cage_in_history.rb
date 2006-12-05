class CageInHistory < ActiveRecord::Base
    belongs_to :bat
    belongs_to :cage
    belongs_to :user
end