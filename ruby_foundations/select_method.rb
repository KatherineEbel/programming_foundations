def select(arr)
  new_arr = []
  for i in 0..arr.size - 1 do
    new_arr << arr[i] if yield arr[i]
  end
  new_arr
end

array = [1,2,3,4,5]

select(array) { |num| num.odd? }
select(array) { |num| puts num }
select(array) { |num| num + 1 }
