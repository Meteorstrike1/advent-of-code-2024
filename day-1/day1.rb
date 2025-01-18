file = File.readlines('inputday1', chomp: true)

left_list = []
right_list = []

file.each do |row|
  split = row.split(' ')
  left_list << split[0].to_i
  right_list << split[1].to_i
end

sorted_left = left_list.sort
sorted_right = right_list.sort
zipped = sorted_left.zip(sorted_right)

# Part 1
differences = []

zipped.each do |left, right|
  differences << (left - right).abs
end

total = differences.reduce(:+)
puts "Part 1: #{total}"

# Part 2
similarity_score = []

sorted_left.each do |num|
  if sorted_right.include?(num)
    occurrences = sorted_right.count(num)
    similarity_score << (num * occurrences)
  end
end

total_score = similarity_score.reduce(:+)
puts "Part 2: #{total_score}"
