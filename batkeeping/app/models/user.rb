class User < ActiveRecord::Base
    has_many :cages, :order => 'name'
    has_many :bats, :order => 'band'
    has_many :cage_in_histories
    has_many :cage_out_histories
    has_many :medical_problems
    has_many :tasks
end