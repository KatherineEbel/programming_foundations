# good_dog.rb

# class GoodDog
#   DOG_YEARS = 7 # constants need to start with capital, but usually entire capitals
#   attr_accessor :name, :height, :weight  # takes symbol as an argument. creates getters and setters for instance variables
#   def initialize(n, h, w)
#     self.name = n # instance variables hold state for objects
#     self.height = h
#     self.weight = w
#     self.age = a * DOG_YEARS
#   end
#
#   def self.what_am_i  # Class method definition
#     "I'm a GoodDog class!"
#   end
#   # as convention name getter and setter method after the varible you are exposing or setting.
#   # def name # getter for name instance variable
#   #   @name
#   # end
#   #
#   # def name=(name) # setter for name instance variable
#   #   @name = name
#   # end
#
#   def speak # instance methods contain functionality
#     "#{name}Arf!"  # without attr_* method would access name with @name
#   end
#
#   def change_info(n, h, w)
#     self.name = n
#     self.height = h
#     weight = w
#   end
#
#   def info
#     "#{name} weight #{weight} and is #{height} tall."
#   end
#
#   def to_s #overriding this we can change how object is displayed when doing "puts"
#     "This dog's name is #{name} and it is #{age} in dog years."
#   end
# end
#
# sparky = GoodDog.new("Sparky")
# puts sparky.speak
# puts sparky.get_name
# sparky.set_name = "Spartacus" # actual method is set_name=
# puts sparky.get_name
#
# sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
# puts sparky.info  # => Sparky weights 10 lbs and is 12 inches tall
#
# sparky.change_info('Spartacus', '24 inches', '45 lbs')
# puts sparky.info


# below will create an error because the attr_reader only creates a getter and not a setter. e can create an attr_writer or an attr_accessor to correct the error.
class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end

end

bob = Person.new 'Steve'
bob.name = "Bob"
p bob.name
