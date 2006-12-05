class ProtocolEndHistory < ActiveRecord::Base
    belongs_to :bat
    belongs_to :protocol
    belongs_to :user
    belongs_to :protocol_start_hsitory
end
