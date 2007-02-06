class Cage < ActiveRecord::Base
    belongs_to  :user
	has_many :bats, :order => 'band'
	has_many :cage_in_histories, :order => "date desc"
	has_many :cage_out_histories, :order => "date desc"
    has_many :tasks, :order => "repeat_code"
  
  @@colony = 'Colony Room (4100)'
  @@belfry = 'Belfry (4102F)'
  @@fruitbat = 'Fruit Bats (4148L)'
  
  def self.active
    find :all, :conditions => 'date_destroyed is null', :order => 'name'
  end
  
  def self.has_bats
    @cages = find :all, :order => "name"
    for cage in @cages
      @cages.delete_if{|cage| cage.bats.length == 0}
    end
    return @cages
  end
  
  def self.active_colony_cages
    find :all, :conditions => "date_destroyed is null and room = '#{@@colony}'", :order => 'name'
  end
  
  def self.active_belfry_cages
      find :all, :conditions => "date_destroyed is null and room = '#{@@belfry}'", :order => 'name'
  end
  
  def self.active_fruitbat_cages
      find :all, :conditions => "date_destroyed is null and room = '#{@@fruitbat}'", :order => 'name'
  end
  
  def average_bat_weight
    if self.bats.length > 0
      combined_weights = 0.0
      for bat in self.bats
        combined_weights = combined_weights + bat.weights.recent[0].weight
      end
      average = combined_weights/self.bats.length
      return (("%.0" + 1.to_s + "f") %average).to_f
    end
  end
  
  def food_today
    food = 0
    self.tasks.feeding_tasks_today.each {|task| task.food ? food = food + task.food : food }
    return food
  end
  
  def food_this_week
    food = 0
    self.tasks.feeding_tasks.each {|task| task.food ? food = food + task.food : food }
    return food
  end
  
  def weighed_enough?
    if self.tasks.weighing_tasks.length < 2
      return false
    else
      return true
    end
  end
  
  def fed_today?
    today = Date.today.wday + 1 #to bring in line with repeat_codes
    for task in self.tasks.feeding_tasks
      if (task.repeat_code == today && task.done_by_schedule == true)
        return true
      end
    end
    return false
  end
    
  def fed_every_day?
    if self.tasks.feeding_tasks.length < 7
      return false
    end
    
    day = 0
    7.times do
      task_exists = false
      day = day + 1
      self.tasks.feeding_tasks.each{|task| (task.repeat_code == day) ? task_exists = true : '' }
      if task_exists == false 
        return false
      end
    end
    return true
  end
  
  def update_weighing_tasks
    most_ancient_recent_weight = Time.now
    bats_have_weights = false
    for bat in self.bats
      if bat.weights.length > 0
        bats_have_weights = true
        if most_ancient_recent_weight > bat.weights.recent[0].date.to_time
          most_ancient_recent_weight = bat.weights.recent[0].date.to_time
        end
      end
    end
    if bats_have_weights
      for task in self.tasks
        post = task.find_post
        if (Date.today.yday >= post && Date.today.yday <= post + 2)
          task.last_done_date = most_ancient_recent_weight
          task.save
        end
      end
    end
  end
  
end