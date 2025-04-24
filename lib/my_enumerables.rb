module Enumerable
  # Your code goes here
  def my_each_with_index(&block)
    result = []
    position = 0
    self.my_each do |item|
      result << block.call(item, position)
      position += 1
    end
  end

  def my_select(&block)
    result = []
    self.my_each do |item|
      result << item if block.call(item)
    end
    result
  end

  def my_all?(&block)
    if !block_given?
      block = Proc.new { |item| item }
    end

    all_passed = true
    self.my_each do |item|
      unless block.call(item)
        all_passed = false
        break
      end
    end
    return all_passed
  end

  def my_none?(&block)
    if !block_given?
      block = Proc.new { |item| item }
    end

    self.my_each do |item|
      if block.call(item)
        return false
      end
    end
    return true
  end

  def my_count(search_value = nil, &block)
    counter = 0
    if block_given?
      self.my_each do |item|
        if block.call(item)
          counter += 1
        end
      end
    elsif search_value != nil
      self.my_each do |item|
        if item == search_value
          counter += 1
        end
      end
    else
      self.my_each do |_|
        counter += 1
      end
    end
    return counter
  end

  def my_map(&block)
    result = []
    self.my_each do |item|
      result << block.call(item)
    end
    result
  end

  def my_inject(intial_value = nil, symbol = nil, &block)

  end

end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each(&block)
    for i in 0...self.length
      block.call(self[i])
    end
    return self
  end
end