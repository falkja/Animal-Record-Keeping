# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Produces -> May 25, 2006
  #http://www.ruby-doc.org/core/classes/Time.html#M000304
  def nice_date(date)
    if (date != nil)
      date.strftime("%B %d, %Y")
    else
      'N/A'
    end
  end

  # Produces -> May 2006
  def nice_date_no_day(date)
    if (date != nil)
      date.strftime("%b %Y")
    else
      'N/A'
    end
  end
  
  # Produces -> May 25
  def nice_date_no_year(date)
    if (date != nil)
      date.strftime("%b %d")
    else
      'N/A'
    end
  end
  
  # Produces -> May 25, 2006, 04:16 PM
  def nice_date_with_time(date)
    if (date != nil)
      date.strftime("%B %d, %Y, %I:%M %p")
    else
      'N/A'
    end
  end
  
	# Produces -> Sunday, May 25, 2006, 04:16 PM
	def nice_date_with_dow_and_time(date)
    if (date != nil)
      date.strftime("%A, %B %d, %Y, %I:%M %p")
    else
      'N/A'
    end
	end
	
  #given an array of cages, returns number of bats in them
  def bats_in_cages(cages)
    bats = Array.new
    cages.each {|cage| bats << cage.bats}
    bats.flatten!
    return bats.length
  end
  
  #from http://neoarch.wordpress.com/2008/02/29/setting-focus-in-rails-with-prototype/
  def set_focus_to_id(id)
	javascript_tag("$('#{id}').focus()");
  end
  
end