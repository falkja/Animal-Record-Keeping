class Cage < ActiveRecord::Base
    belongs_to  :user
	has_many :bats, :order => 'band'
	has_many :cage_in_histories, :order => "date desc"
	has_many :cage_out_histories, :order => "date desc"
    has_many :tasks, :order => "repeat_code"
    belongs_to :room
  
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
  
  def self.has_feeding_tasks
	@cages = find :all, :order => "name"
		for cage in @cages
			@cages.delete_if{|cage| cage.tasks.feeding_tasks.length == 0}
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
	num_bats_with_weights = 0
	for bat in self.bats
		if bat.weights.length > 0 
			combined_weights = combined_weights + bat.weights.recent.weight
			num_bats_with_weights = num_bats_with_weights + 1
		end
	end
	if num_bats_with_weights > 0 
		average = combined_weights/num_bats_with_weights
		return (("%.0" + 1.to_s + "f") %average).to_f
	else
		return nil
	end
    else 
	return nil
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
  
  def oldest_recent_weight #this function returns the oldest of the dates of all the bats recent weights
		#initializing
    oldest_recent_weight = Time.now
    
    for bat in self.bats
      bats_have_weights = false
			if bat.weights.length > 0 #this bat has weights
        all_bats_have_weights = true
        if oldest_recent_weight > bat.weights.recent.date.to_time
          oldest_recent_weight = bat.weights.recent.date.to_time
        end
      end
    end
		
		if all_bats_have_weights
			return oldest_recent_weight
		else
			return nil
		end
  end
  
  def update_weighing_tasks #marks the cage's weighing tasks as being done with the appropriate date and returns the list of tasks it updates
    tasks = Array.new
		
		oldest_recent_weight = self.oldest_recent_weight
		if oldest_recent_weight != nil
      for task in self.tasks.weighing_tasks
        task.done_with_date(oldest_recent_weight)
				if (task.last_done_date == oldest_recent_weight)
					tasks << task
				end
      end
    end
		
		return tasks
  end
  
end