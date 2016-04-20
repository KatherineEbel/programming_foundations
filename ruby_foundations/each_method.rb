def each(arr)
  for i in 0..(arr.size - 1) do
    yield arr[i]
  end
  arr
end

each([1,2,3]) do |item|
  puts item
end
