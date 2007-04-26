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
      date.strftime("%B %Y")
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
  
  #given an array of cages, returns number of bats in them
  def bats_in_cages(cages)
    bats = Array.new
    cages.each {|cage| bats << cage.bats}
    bats.flatten!
    return bats.length
  end
  
end