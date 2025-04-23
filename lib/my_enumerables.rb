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