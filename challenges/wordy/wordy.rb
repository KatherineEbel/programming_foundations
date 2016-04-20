# This is my first challenge. I know there is probably a more elegant solution, but this is
# what made the most sense to me with my still somewhat limited ruby skills. (There has got
# to be a way to shorten my answer method but not sure I can given the way
# I formatted the values. All the tests passed, so proud of that if nothing else!

require 'pry'

# The WordProblem class takes a word problem and returns the answer as an integer.
class WordProblem
  OPERATORS = { 'plus' => '+', 'minus' => '-',
                'multiplied' => '*', 'divided' => '/' }.freeze
  def initialize(problem)
    @problem = problem
    validate_problem
  end

  def validate_problem
    too_complicated?
    irrelevant?
  end

  def too_complicated?
    values = to_a.select { |value| OPERATORS.include?(value) }
    values.empty? ? raise(ArgumentError, "Too complicated!") : false
  end

  def irrelevant?
    values = to_a.select { |value| valid_number?(value) }
    values.empty? ? raise(ArgumentError, "Irrelevant problem!") : false
  end

  def to_a
    remove_punctuation.split ' '
  end

  def valid_number?(num)
    num.to_i.to_s == num
  end

  def remove_punctuation
    @problem.delete '?'
  end

  def values_for_problem
    converted_values = to_a.map do |value|
      if valid_number?(value)
        value.to_i
      elsif OPERATORS.key?(value)
        OPERATORS[value]
      end
    end
    converted_values.compact
  end

  def answer
    total = 0
    operator = nil
    values_for_problem.each do |value|
      if operator && value.is_a?(Fixnum)
        total = total.send(operator, value)
      elsif value.is_a? Fixnum
        total += value
      else
        operator = value 
      end
    end
    total
  end
end
