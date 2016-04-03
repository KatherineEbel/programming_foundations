# my_car.rb

module FourWheelDriveable
  def four_wheel_drive
    puts "Driving on the beach!"
  end
end
class Vehicle
  attr_accessor :color
  attr_reader :year
  @@number_of_descendants = 0
  def initialize(year, color, model)
    @@number_of_descendants += 1
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end

  def self.number_of_descendants
    puts "There are #{@@number_of_descendants} objects of the Vehicle class"
  end

  def self.gas_milage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def speed_up(mph)
    @current_speed += mph
    puts "Accelerated car by #{mph}, current speed is: #{@current_speed}"

  end

  def brake
    @current_speed -= mph
    puts "Decelerated car by #{mph}, current speed is: #{current_speed}"
  end

  def shut_off
    @current_speed = 0
  end

  def spray_paint(color)
    self.color = color
    puts "#{@model}'s new color #{color}"
  end

  def display_year
    puts "#{@model} is a #{year}"
  end

  def to_s
    "This is a #{@year}, #{@color} #{@model}"
  end

  def age
    puts "#{@model} is #{calculate_age} years old"
  end

  private

  def calculate_age
    Time.now.year - year
  end
end


class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  def number_of_doors
    puts "#{@model} has #{NUMBER_OF_DOORS} doors"
  end
end

class MyTruck < Vehicle
  include FourWheelDriveable
  NUMBER_OF_DOORS = 2
end




car = MyCar.new(2016, "Blue", "Jeep")
car.number_of_doors
# car.speed_up 40
# puts car.color
# puts car
# car.spray_paint "Silver"
# car.display_year
# MyCar.gas_milage(13, 351)

# puts MyCar.ancestors
# puts MyTruck.ancestors
# Vehicle.number_of_descendants
# sedan = MyCar.new(2016, 'red', 'Civic')
# jeep = MyTruck.new(2014, 'blue', 'Jeep')
# Vehicle.number_of_descendants
# sedan.spray_paint 'yellow'
# jeep.speed_up 50
# jeep.age
# jeep.calculate_age


# class Student
#   def initialize(name, grade)
#     @name = name
#     @grade = grade
#   end
#
#   def better_grade_than?(student)
#     puts grade > student.grade ? "Well done!" : "Try harder!"
#   end
#
#   protected
#
#   def grade
#     @grade
#   end
# end
#
# joe = Student.new('Joe', 90)
# bob = Student.new('Bob', 85)
#
# joe.better_grade_than? bob

# Question 8
# If 'hi' is  a private method, it is not available to the object.
# Can fix by moving the definition of hi above the line private.
