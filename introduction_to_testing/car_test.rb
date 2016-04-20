require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'car'

class CarTest < Minitest::Test
  # def setup
  #   @car = Car.new
  # end

  def test_value_equality
    car1 = Car.new
    car2 = Car.new

    car1.name = "Kim"
    car2.name = "Kim"

    assert_equal car1, car2
    assert_same car1, car2
  end
  # # each method in test class must start with test_
  # def test_wheels
  #   # assert_equal takes two parameters
  #   # 1. expected value 2. actual value
  #   assert_equal(4, @car.wheels)
  # end
  #
  # def test_bad_wheels
  #   skip "Don't want to run this test now"
  #   assert_equal(3, @car.wheels)
  # end
  # # assert
  # def test_car_exists
  #   assert @car
  # end
  #
  # #assert_nil
  # def test_name_is_nil
  #   assert_nil(@car.name)
  # end
  #
  # #assert_raises
  # def test_raise_initialize_with_arg
  #   assert_raises ArgumentError do
  #     car = Car.new(name: "Joey") # this code raises error
  #   end
  # end
  #
  # #assert_instance_of
  # def test_instance_of_car
  #   car = Car.new
  #   assert_instance_of(Car, @car)
  # end
  #
  # #assert_includes
  # def test_includes_car
  #   car = Car.new
  #   arr = [1, 2, 3]
  #   arr << car
  #   assert_includes arr, @car
  # end
end
