require 'pry'

class School
  def initialize
    @roster = {}
  end

  def to_h
    result = {}
    @roster.keys.sort.each do |key|
      result[key] = @roster[key].sort
    end
    result
  end

  def add(name, _grade)
    grade(_grade).push name
  end

  def grade(key)
    @roster[key] || @roster[key] = []
  end
end
