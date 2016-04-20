class Series
  def initialize(value)
    @value = value
    @marker = 0
  end

  def slices(slice_size)
    raise ArgumentError if slice_size > length
    sets = []
    number_array.each do |_|
      next if @marker > stop(slice_size)
      sets << add_set(slice_size)
      @marker += 1
    end
    sets
  end

  private

  def add_set(size)
    set = []
    counter = @marker
    size.times do
      set << number_array.slice(counter, 1)
      counter += 1
    end
    set.flatten
  end

  def number_array
    @value.split('').map(&:to_i)
  end

  def length
    @value.size
  end

  def stop(size)
    length - size
  end
end
