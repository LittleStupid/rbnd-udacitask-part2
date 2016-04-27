class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    if( false == valid_priority?( options[:priority] ) )
     raise UdaciListErrors::InvalidPriorityValue
    end
    
    @description = description
    @due = options[:due] ? Date.parse(options[:due]) : options[:due]
    @priority = options[:priority]
  end
  
  def details
    format_description( @description ) + "due: " +
    format_date_one( @due ) +
    format_priority( @priority )
  end
  
  def valid_priority?( priority )
    return true if priority == "high"
    return true if priority == "midium"
    return true if priority == "low"
    
    return false
  end
end
