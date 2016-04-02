# my_car.rb

class MyCar
  attr_accessor :color
  attr_reader :year
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
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

end


car = MyCar.new(2016, "Blue", "Jeep")
car.speed_up 40
puts car.color
puts car
car.spray_paint "Silver"
car.display_year
MyCar.gas_milage(13, 351)
