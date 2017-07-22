require 'benchmark'
require 'benchmark/ips'

def quicksort(numbers, leftInd, rightInd)
	if numbers.length > 1
		pivotIndex = partition(numbers, leftInd, rightInd)

		if leftInd < pivotIndex - 1
			quicksort(numbers, leftInd, pivotIndex - 1)
		end

		if pivotIndex < rightInd
			quicksort(numbers, pivotIndex, rightInd)
		end
	end

	return numbers

end

def partition(numbers, left, right)
	median = ([left, right].reduce(:+).to_f/2).floor
	pivot = numbers[median]
	l = left
	r = right

	while l <= r do
		while numbers[l] < pivot do
			l+=1
		end
		while numbers[r] > pivot do
			r-=1
		end

		if l <= r
			swap(numbers, l, r)
			l+=1
			r-=1
		end
	end
	
	l
end

def swap(numbers, left, right)
	tempRef = numbers[left]
	numbers[left] = numbers[right]
	numbers[right] = tempRef
end

def bubble_sort(list)
  return list if list.size <= 1 # already sorted
  swapped = true
  while swapped do
    swapped = false
    0.upto(list.size-2) do |i|
      if list[i] > list[i+1]
        list[i], list[i+1] = list[i+1], list[i] # swap values
        swapped = true
      end
    end    
  end

  list
end

numbers = Array.new(500) { rand(-1000...1000) }

Benchmark.ips do |x|
	x.report("bubble-sort") { bubble_sort(numbers.dup) }
  x.report("custom-quicksort") { quicksort(numbers.dup, 0, numbers.length - 1).join(" ") }
  x.report("ruby-sort") { numbers.dup.sort }
  x.compare!
end

Benchmark.bmbm do |x|
	x.report("bubble-sort") { bubble_sort(numbers.dup) }
	x.report("custom-quicksort") { quicksort(numbers.dup, 0, numbers.length - 1).join(" ") }
  x.report("ruby-sort") { numbers.dup.sort }
end
