class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

teddy = Dog.new
puts teddy.speak
puts teddy.swim

class BullDog < Dog
  def swim
    "can't swim!"
  end
end

karl = BullDog.new
puts karl.speak
puts karl.swim

class Cat < Pet
  def speak
    'meow!'
  end
end

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = BullDog.new

puts pete.run
# puts pete.speak error

puts kitty.run
puts kitty.speak
# puts kitty.fetch

puts dave.speak

puts bud.run
puts bud.swim

puts Pet.ancestors
puts Cat.ancestors

      # Pet
    # Dog    Cat
# BullDog

# method lookup is how a class searches for methods that it can call on it's class. If not defined in it's class it will look up in hierarchy until it finds the method, or it will return a nomethod error.
