require 'pry'

class School
  def initialize
    @roster = {}
  end

  def to_h
    binding.pry
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

school = School.new
[
     ['Jennifer', 4], ['Kareem', 6],
     ['Christopher', 4], ['Kyle', 3]
   ].each do |name, grade|
     school.add(name, grade)
   end

school.to_h
