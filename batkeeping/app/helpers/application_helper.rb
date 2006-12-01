# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Produces -> May 25, 2006
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
  
end
