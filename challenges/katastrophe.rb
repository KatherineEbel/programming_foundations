require 'pry'
# def strong_enough( earthquake, age )
#   strength = 1000
#   total = Array.new
#   earthquake.each do |shockwave|
#     total << shockwave.inject(0, :+)
#   end
#   quake = total.inject(1, :*)
#   decay_total = strength(strength, age)
#   decay_total >= quake ? "Safe!" : "Needs Reinforcement!"
# end
#
# def strength(value, years)
#   if years > 0
#     value = value - value * 0.01
#     years -= 1
#     strength(value, years)
#   else
#     return value.round
#   end
# end
#
#
# puts strong_enough([[2,3,1],[3,1,1],[1,1,2]], 2)
# puts strong_enough([[5,8,7],[3,3,1],[4,1,2]], 2)
# puts strong_enough([[5,8,7],[3,3,1],[4,1,2]], 3)

# def unused_digits(*digits)
#   string = digits.join
#   binding.pry
#   [*1..9].map { |num| num if !string.include? num.to_s }.join
# end
#
# puts unused_digits(12, 34, 56, 78)
# puts unused_digits(2015, 8, 26)

# def accum(s)
#   result = ""
#   s.chars.each_with_index do |char, idx|
#     (idx + 1).times do |count|
#       if count + 1 == 1
#         result << char.upcase
#       else
#         result << char.downcase
#       end
#     end
#     result << '-'
#   end
#   result.chop
# end
#
# puts accum("ZpglnRxqenU")

def sum_pairs(ints, s)
    #for each int in ints select values that add up to s
    ints.each_with_index do |int, index|
      binding.pry
      counter = index
      while counter < ints.size
        if int + ints[index + counter] == s
          return [int, ints[index + counter]]
        end
        counter += 1
      end
    end
end
l1= [1, 4, 8, 7, 3, 15]
#    sum_pairs(l1, 8)
l2= [1, -2, 3, 0, -6, 1]
p sum_pairs(l2, -6)
