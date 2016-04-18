#The algorithm consists of repeating the
# following over and over
# take the next available unmarked number in your list(it is prime)
# mark all the multiples of that number (they are not prime)
require 'pry'

class Sieve
  def initialize(range_max)
    @range_max = range_max
    @primes = []
    @marked = []
    sort_primes
  end

  def to_a
    (2..@range_max).to_a
  end

  def marked
    @marked
  end

  def primes
    @primes
  end

  def sort_primes
    to_a.each do |num|
      # mark all multiples of num and
      next if marked.include? num
      counter = num
      primes << counter
      while counter < @range_max
         counter += num
         marked << counter
      end
    end
  end
end

p Sieve.new(10).primes
