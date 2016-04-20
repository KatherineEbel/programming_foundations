# yielding

def echo_with_yield(str)
  yield
  str
end

# the yield keyword executes the block
# use Kernel#block_given? method to allow calling method with or without a block.
def echo_with_yield(str)
  yield if block_given?
  str
end

def say(words)
  yield if block_given?
  puts "> " + words
end

say("hi there") do
  system 'clear'
end

# clears screen first, then outputs ">hi there"

def increment(number)
  if block_given?
    yield number + 1
  else
    number + 1
  end
end

increment 5 do |num|
  puts num
end



# write a method that outputs the before and after of manipulating the argument to the method.

# compare('hi') { |word| word.upcase }

# Output:
# Before: hi
# After: HI

def compare(str)
  puts "Before: #{str}"
  after = yield str
  puts "After: #{after}"
end

# method invocation
compare('hi') { |word| word.upcase }
