# def add_eight(number)
#   number + 8
# end
#
# number = 2
#
# how_deep = "number"
#
# 5.times { how_deep.gsub!("number", "add_eight(number)")}
#
# p how_deep
# Kernel.eval(how_deep)

# flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
# hash = {}
#  flintstones.each_index do |index|
#    hash[flintstones[index]] = index
#  end
#
# p hash

# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
# sum = 0
# ages.each_value { |value| sum += value }
# puts sum

# Question 4 easy-2
# munsters_description = "The Munsters are creepy in a good way."
# munsters_description.gsub('M', 'm')

# Question 5
# ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }

# Exercises: Medium 2

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" }
}

# Question 1
# sum = 0
# munsters.each do |key,value|
#   if value['gender'] == 'male'
#     sum +=   value['age']
#   end
# end
# p sum

# Question 2
# munsters.each do |key, value|
#   puts "#{key} is a #{value['age']} year old #{value['gender']}."
# end

# Question 3

# def tricky_method(a_string_param, an_array_param)
#   a_string_param += "rutabaga"
#   an_array_param += "rutabaga"
# end
#
# my_string = "pumpkins"
# my_array = ["pumpkins"]
# tricky_method(my_string, my_array)
#
# puts "My string looks like this now: #{my_string}"
# puts "My array looks like this now: #{my_array}"

# Question 4

# sentence = "Humpty Dumpty sat on a wall."
# sentence_array = sentence.split /\W/
# sentence_array.reverse!
# backwards = sentence_array.join(' ') + '.'
# p backwards

# Question 5
# answer = 42
#
# def mess_with_it(some_number)
#   some_number += 8
# end
#
# new_answer = mess_with_it(answer)
#
# p answer - 8

# Exercises: medium 3

# Question 5

# def color_valid(color)
#   color == 'blue' || color == 'green'
# end
#
# puts color_valid 'blue'
# puts color_valid 'green'
# puts color_valid 'purple'

# Exercises: Hard 1
# def mess_with_vars(one, two, three)
#   one = two
#   two = three
#   three = one
# end
#
# one = "one"
# two = "two"
# three = "three"
#
# mess_with_vars(one, two, three)
#
# puts "one is: #{one}"
# puts "two is: #{two}"
# puts "three is: #{three}"

# def mess_with_vars(one, two, three)
#   one = "two"
#   two = "three"
#   three = "one"
# end
#
# one = "one"
# two = "two"
# three = "three"
#
# mess_with_vars(one, two, three)
#
# puts "one is: #{one}"
# puts "two is: #{two}"
# puts "three is: #{three}"

# def mess_with_vars(one, two, three)
#   one.gsub!("one","two")
#   two.gsub!("two","three")
#   three.gsub!("three","one")
# end
#
# one = "one"
# two = "two"
# three = "three"
#
# mess_with_vars(one, two, three)
#
# puts "one is: #{one}"
# puts "two is: #{two}"
# puts "three is: #{three}"

# Question 4
# def create_uuid
#   values = %w(0 1 2 3 4 5 6 7 8 9 a b c d e f)
#   uuid = ''
#   8.times { |_| uuid += values.sample}
#   uuid += '-'
#   3.times do |_|
#     4.times { |_| uuid += values.sample}
#     uuid += '-'
#   end
#   12.times { |_| uuid += values.sample}
#   uuid
# end
#
# uuid = create_uuid
# puts uuid

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false if dot_separated_words.size != 4
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false if !is_a_number?(word)
  end
  true
end

p dot_separated_ip_address? '10.2.3'
