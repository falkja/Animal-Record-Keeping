# admin stuff
#
class AdminController < ApplicationController
  
	def index
    redirect_to :create_fake_data
	end
	
	def create_fake_data
	end
  
  	#Generate a lot of random data for testing
	def testing_data
		
		#create random cages
		rooms = ['Belfry (4102F)', 'Colony Room (4100)', 'Fruit Bats (4148L)']
		users = User.current
		for n in 1..5
			cage = Cage.new
			cage.name = "random#{n}"
			cage.room = rooms[rand(3)]
			cage.date_created = Date.new(2000+rand(6),rand(12)+1,rand(27)+1)
			cage.user = users[rand(users.length)]
			if rand(10) > 8
				cage.date_destroyed = cage.date_created + rand(365)
			end
			cage.save
		end
		
		
		#create random bats and assign them to random cages
		col_band = ("a".."z").to_a
		cages = Cage.active
		for n in 1..20
			bat = Bat.new
			bat.band = "#{col_band[rand(col_band.size-1)]}#{rand(20)}"
			bat.species = 'Eptesicus fuscus'
			bat.gender = 'M'
			bat.collection_age = 'Adult'
			bat.collection_date = Date.new(2000+rand(6),rand(12)+1,rand(27)+1)
			bat.collection_place = 'erewhon'
			bat.cage = cages[rand(cages.length)]
			bat.save
			
			#Move the bats around randomly
			for m in 1..rand(5)
				bat.cage = cages[rand(cages.length)]
				Bat::set_user_and_comment(users[0], 'random') #Do this before saving!
				bat.save
			end
			
			#Deactivate a random number of bats
			if rand(10) > 8
				bat.leave_date = bat.collection_date + rand(365)
			end
			bat.save
			
		end        
		
		
		
		#create random feeding tasks with random food
		for n in 1..20
			task = Task.new
			task.cage = cages[rand(cages.length)] 
			task.date_started = task.cage.date_created + rand(365)
			task.internal_description = 'feed'
			task.food = rand(50)
			task.dish_type = 'Gigantic'
			task.dish_num = 2
			task.title = 'random'
			task.jitter = 3
			task.repeat_code = rand(8)
			if rand(10) > 8
				task.date_ended = task.date_started + rand(100)
			end			
			task.save
		end
		
		#create random temp and humidity entries
		for n in 1..200
			tandh = Weather.new
			tandh.log_date = Date.new(2006,rand(12)+1,rand(27)+1)
			tandh.temperature = rand(30) + 10
			tandh.humidity = rand(100)
			tandh.room = rooms[rand(3)]
			tandh.sig = 'random'
			tandh.save
		end
		
		
		redirect_to :controller => 'bats', :action => 'list'
	end
	
	def erase_testing_data
		Cage.destroy_all "name like 'random%'"
		Bat.destroy_all "collection_place = 'erewhon'"
		Task.destroy_all "title = 'random'"
		Weather.destroy_all "sig = 'random'"
		Cage_In_Histories.destroy_all "note = 'random'"
		Cage_Out_Histories.destroy_all "note = 'random'"
		redirect_to :controller => 'bats', :action => 'list'		
	end
  
end