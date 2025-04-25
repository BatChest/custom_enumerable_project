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

  def my_inject(initial_value = nil, symbol = nil, &block)
    # Determine operation type and initial value
    if block_given? && initial_value.is_a?(Symbol) && symbol.nil?
      # Special case: inject(:symbol) was used, moving args
      symbol = initial_value
      initial_value = nil
    end

    # Set up accumulator and starting point
    if initial_value.nil? && !self.empty?
      accumulator = self.first
      start_index = 1
    elsif !initial_value.nil?
      accumulator = initial_value
      start_index = 0
    else
      raise "Cannot call inject on an empty collection without an initial value"
    end

    # Perform the accumulation
    self.my_each_with_index do |element, index|
      next if index < start_index

      if block_given?
        accumulator = block.call(accumulator, element)
      elsif symbol.is_a?(Symbol)
        accumulator = accumulator.send(symbol, element)
      else
        raise ArgumentError, "Invalid arguments for my_inject"
      end
    end

    return accumulator
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