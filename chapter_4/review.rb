# def prefix(str)
#   "Mr. " << str
# end
#
# name = 'joe'
# prefix name
#
# puts name

arr = [1, 1, 2, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# arr.each { |n| puts n if n > 5 }

# arr.push 12
# arr.insert(0, 0)
# p arr
#
# arr.pop
# arr.push 3
# p arr

arr.uniq!
p arr

# select returns a new array based on the block's return value. If the return value evalutates to true, then the element is selected
odds = arr.select {|n| n.odd?}
sum = arr.inject(:+)
p odds
p sum

# map returns a new ar

incremented = arr.map { |n| n += 1 }
p incremented
p arr
