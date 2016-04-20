# reduce_method.rb

def reduce(arr, acc = 0)
  counter = 0
  while counter < arr.size 
    acc = yield(acc, arr[counter])
    counter += 1
  end
  acc
end

reduce(array) { |acc, num| acc + num }                    # => 15
reduce(array, 10) { |acc, num| acc + num }                # => 25
reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass
