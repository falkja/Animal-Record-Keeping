class User < ActiveRecord::Base
    has_many :cage_in_histories
    has_many :cage_out_histories
end