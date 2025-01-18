# Done at the time but got stuck trying to make a solution that would work for part 2
file = File.read('inputday11')
line = file.split(' ')
stones = line.map(&:to_i)

def rules_to_stone(stone)
  if stone == 0
    stone = 1
  elsif stone.to_s.length.even?
    half_size = stone.to_s.length / 2
    left = stone.to_s[0...half_size]
    right = stone.to_s[half_size..]
    stone = [left.to_i, right.to_i]
  else
    stone = stone * 2024
  end
  stone
end

25.times do
  stones = stones.map do |stone|
    rules_to_stone(stone)
  end
  stones.flatten!
end

puts stones.count
