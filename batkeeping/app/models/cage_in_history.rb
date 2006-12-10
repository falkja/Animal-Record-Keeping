class CageInHistory < ActiveRecord::Base
    belongs_to :bat
    belongs_to :cage
    belongs_to :user
    has_one :cage_out_history
    
    #From http://www.therailsway.com/tags/rails
    #Lets us do cage.cage_in_histories.recent
    def self.recent
        find :all, :conditions => 'date > ' + (Time.new - 2 ).strftime("%Y-%m-%d")
    end
    
end