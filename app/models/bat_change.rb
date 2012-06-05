class BatChange < ActiveRecord::Base
  belongs_to :bat
  belongs_to :medical_treatment
  belongs_to :user
  belongs_to :cage_in_history
  belongs_to :protocol_history
  has_one :protocol, :through => :protocol_history
  belongs_to :surgery
  
  #either activated or deactivated today
  def self.deactivated_today
    BatChange.find(:all, :conditions => ['(updated_at >= ? AND updated_at < ?) AND (bat_id IN (?)) AND ((new_cage_id is null and old_cage_id is not null) OR (new_cage_id is not null and old_cage_id is null) )',
        Date.today.to_time, (Date.today + 1.day).to_time, Bat.all])
  end
  
  #either activated or deactivated today
  def self.users_bats_deactivated_today(user)
    BatChange.find(:all, :conditions => ['(updated_at >= ? AND updated_at < ? AND ((new_cage_id is null and old_cage_id is not null) OR (new_cage_id is not null and old_cage_id is null) ) ) AND (user_id = ? OR old_cage_id IN (?) OR new_cage_id IN (?))',
        Date.today.to_time, (Date.today + 1.day).to_time, user, user.cages, user.cages])
  end
  
  def self.search(search)
    if !search.empty?
      find(:all, 
        :conditions => ['note LIKE ?',"%#{search}%"],
        :order => "date desc")
    else
      return []
    end
  end
end