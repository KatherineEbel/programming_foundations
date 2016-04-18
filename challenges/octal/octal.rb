require 'pry'

# The Octal class takes digit string and converts it
# to an octal number if valid.
class Octal
  def initialize(val)
    @numbers = val.chars.map(&:to_i)
  end

  def invalid?
    @numbers.any? { |num| [8, 9].include? num }
  end

  def to_decimal
    return 0 if invalid?
    power = @numbers.size - 1
    @numbers.each_with_index.inject(0) do |sum, (num, index)|
      sum + num * 8 ** (power - index)
    end
  end
end
