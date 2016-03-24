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
munsters_description = "The Munsters are creepy in a good way."
munsters_description.gsub('M', 'm')

# Question 5
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
