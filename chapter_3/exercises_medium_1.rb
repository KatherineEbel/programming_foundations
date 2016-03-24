# Question 2
# statement = "The Flintstones Rock"
# hash = {}
# statement.each_char do |char|
#   hash[char] = statement.delete(' ').scan(char).count
# end
# hash.delete ' '
# p hash

# Question 5

# def factors(number)
#   dividend = number
#   divisors = []
#   while dividend > 0 do
#     divisors << number / dividend if number % dividend == 0
#     dividend -= 1
#   end
#   divisors
# end
#
# p factors 0
# p factors 9



# def fib(first_num, second_num)
#   limit = 15
#   while second_num < limit
#     sum = first_num + second_num
#     first_num = second_num
#     second_num = sum
#   end
#   sum
# end
#
# result = fib(0, 1)
# puts "result is #{result}"
# Question 8
# def titleize!(string)
#   string_array = string.split(' ')
#   string_array.each { |word| word.capitalize!}.join ' '
# end
#
# puts titleize! 'titleize this title'

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

hash = munsters.each do |key, value|
  case value['age']
  when 0..18 then value['age group'] = 'kid'
  when 18..65 then value['age group'] = 'adult'
  else
    value['age group'] = 'senior'
  end
end
p hash
