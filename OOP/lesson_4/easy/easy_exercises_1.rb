# Question 2

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

# car = Car.new
# truck = Truck.new
#
# puts car.is_a? Speed
# puts truck.is_a? Speed
#
# car.go_fast
# truck.go_fast

# Question 5

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# hot_pizza = Pizza.new 'cheese'
# orange = Fruit.new 'apple'
#
# p hot_pizza.instance_variables
# p orange.instance_variables

class Cube
  # attr_accessor :volume
  def initialize(volume)
    @volume = volume
  end

  def volume
    @volume
  end
end

cube = Cube.new 20
p cube.volume
