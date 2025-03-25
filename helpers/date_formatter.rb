module DateFormatter
  # Returns a formatted date string in French
  # Example output: "Lundi 24 mars 2025"
  def formatted_date
    # Define day names in French
    days = { 
      "Monday" => "Lundi", 
      "Tuesday" => "Mardi", 
      "Wednesday" => "Mercredi", 
      "Thursday" => "Jeudi", 
      "Friday" => "Vendredi", 
      "Saturday" => "Samedi", 
      "Sunday" => "Dimanche" 
    }
    # Define month names in French
    months = { 
      "January" => "janvier", 
      "February" => "février", 
      "March" => "mars", 
      "April" => "avril", 
      "May" => "mai", 
      "June" => "juin", 
      "July" => "juillet", 
      "August" => "août", 
      "September" => "septembre", 
      "October" => "octobre", 
      "November" => "novembre", 
      "December" => "décembre" 
    }
    
    # Get current time
    date = Time.now
    
    # Format the day and month using French names
    day_fr = days[date.strftime("%A")]
    month_fr = months[date.strftime("%B")]
    
    # Return the formatted date string
    "#{day_fr} #{date.strftime('%d')} #{month_fr} #{date.strftime('%Y')}"
  end
end
