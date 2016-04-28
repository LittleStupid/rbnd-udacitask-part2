class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    if( false == valid_priority?( options[:priority] ) )
     raise UdaciListErrors::InvalidPriorityValue
    end
    
    @description = description
    
    
    @due = options[:due] ? Date.parse((Chronic.parse(options[:due])).to_s[0,10]) : options[:due]
    @priority = options[:priority]
    
    @type = "todo"
  end
  
  def details
    "(" + @type + ")" +
    format_description( @description ) + "due: " +
    format_date_one( @due ) +
    format_priority( @priority )
  end
  
  def valid_priority?( priority )
    return true if priority == nil
    
    return true if priority == "high"
    return true if priority == "medium"
    return true if priority == "low"
    
    puts priority
    
    return false
  end
end
