# Exercises: Easy 2
# Question 1
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

# What is the result of calling:
oracle = Oracle.new
puts oracle.predict_the_future

# Question 2

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

# trip = RoadTrip.new
# trip.predict_the_future

# Question 3

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

# flavor = Orange.new
# puts Orange.ancestors
#
# flavor1 = HotSauce.new
# puts HotSauce.ancestors

# Question 7

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

puts Cat.cats_count
fuzzy = Cat.new 'Tabby'
puts Cat.cats_count
mittens = Cat.new 'Black and White'
puts Cat.cats_count
