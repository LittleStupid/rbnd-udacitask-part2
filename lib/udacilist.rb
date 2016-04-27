class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end
  
  def valid_type?( type )
    return true if type == "todo"
    return true if type == "event"
    return true if type == "link"
    
    return false
  end
  
  def add(type, description, options={})
    type = type.downcase
    
    if( false == valid_type?( type ) )
      raise UdaciListErrors::InvalidItemType
    end
    
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end
  
  def out_of_items_range?( index )
    index >= @items.length
  end
  
  def delete(index)
    if( true == out_of_items_range?( index ) )
      raise UdaciListErrors::IndexExceedsListSize
    end
    
    @items.delete_at(index - 1)
  end
  
  def all
    puts @title
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
  
  def empty?
    @title.length == 0
  end
  
  def filter( type )
    collection = items.select{ |item| item.type == type }
    if( collection.length == 0 )
      puts "filter nothing"
    end
    
    collection.each{ |item| puts item.type + " : " + item.description }
  end
end
