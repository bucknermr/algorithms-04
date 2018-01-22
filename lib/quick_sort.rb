class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1

    idx = rand(array.length)
    pivot = array[idx]
    left = []
    right = []
    array.each_with_index do |el, i|
      next if i == idx
      if el > pivot
        right << el
      else
        left << el
      end
    end

    self.sort1(left) + [pivot] + self.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length <= 1

    pivot_idx = partition(array, start, length, &prc)

    self.sort2!(array, start, pivot_idx - start, &prc)
    self.sort2!(array, pivot_idx + 1, length - (pivot_idx + 1), &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }

    barrier = start
    pivot = array[start]

    (start + 1...start + length).each do |i|
      if prc.call(pivot, array[i]) == 1
        barrier += 1
        array[barrier], array[i] = array[i], array[barrier]
      end
    end

    array[start], array[barrier] = array[barrier], array[start]
    barrier
  end
end
