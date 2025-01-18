# Had to do a new approach for part 2, tried wrestling with it for hours at the time, came back to it today after figuring out similar for a different puzzle
file = File.read('inputday11')

line = file.split(' ')
stones = line.map(&:to_i)
operations_cache = { 0 => 1 }
stones_hash = stones.tally

def stones_part2(stones, operations_cache, blinks)
    blinks.times do
      temp_hash = Hash.new(0)
      stones.each do |stone, total|
        if operations_cache.include?(stone)
          new_stone = operations_cache[stone]
          if new_stone.is_a?(Array)
            new_stone.each { |value| temp_hash[value] += total }
          else
            temp_hash[new_stone] += total
          end
        elsif stone.to_s.length.even?
          half_size = stone.to_s.length / 2
          left = stone.to_s[0...half_size].to_i
          right = stone.to_s[half_size..].to_i
          temp_hash[left] += total
          temp_hash[right] += total
          operations_cache[stone] = [left, right]
        else
          new_stone = stone * 2024
          temp_hash[new_stone] += total
          operations_cache[stone] = new_stone
        end
      end
      # Update hash after blink
      stones = temp_hash
    end
    stones
  end
  
  result = stones_part2(stones_hash, operations_cache, 75)
  puts result.values.inject(:+)
  