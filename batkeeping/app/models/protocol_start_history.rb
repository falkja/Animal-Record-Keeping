class ProtocolStartHistory < ActiveRecord::Base
    belongs_to :bat
    belongs_to :protocol
    belongs_to :user
    has_one :protocol_end_history
end