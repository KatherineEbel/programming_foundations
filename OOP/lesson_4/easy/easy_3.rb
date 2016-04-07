# Question 1

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# hello = Hello.new
# hello.hi
#
# hello = Hello.new
# hello.by
#
# hello = Hello.new
# hello.greet
#
# hello = Hello.new
# hello.greet "Goodbye"

class Cat
  def initialize(type)
    @type = type
  end

  def to_s
    @type
  end
end


# cat = Cat.new ('Tabby')
# puts cat

# Question 5

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end
