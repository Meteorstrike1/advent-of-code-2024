grid = File.readlines('inputday8', chomp: true).map(&:chars)
antennas = {}

# Hash of each type of antenna with its locations
grid.each_with_index do |row_val, row_i|
  row_val.each_with_index do |col_val, col_i|
    next unless col_val.to_s =~ /[A-z0-9]/
    if antennas.has_key?(col_val)
      antennas[col_val] = antennas[col_val].append([row_i, col_i])
    else
      antennas[col_val] = [[row_i, col_i]]
    end
  end
end

def compare_distance(first, second)
  row_offset = (first[0] - second[0]).abs
  col_offset = (first[1] - second[1]).abs
  [row_offset, col_offset]
end

# Part 2, very repetitive but it is late
def find_antinodes(grid, line)
  remove_boundaries = -> (elem) { elem[0] < 0 || elem[0] > grid.length - 1 || elem[1] < 0 || elem[1] > grid.length - 1 }
  if line.count < 2
    0
  end
  combos = line.combination(2).to_a
  antinodes = []
  combos.each do |first, second|
    row_offset, col_offset = compare_distance(first, second)
    # Multiply to propogate the antinodes
    if first[1] >= second[1]
      grid.length.times do |n|
        antinode = [first[0] - ((n + 1) * row_offset), first[1] + ((n + 1) * col_offset)]
        antinodes << antinode
        break if remove_boundaries.call(antinode)
      end
      grid.length.times do |n|
        antinode = [second[0] + ((n + 1) * row_offset), second[1] - ((n + 1) * col_offset)]
        antinodes << antinode
        break if remove_boundaries.call(antinode)
      end
    else
      grid.length.times do |n|
        antinode = [first[0] - ((n + 1) * row_offset), first[1] - ((n + 1) * col_offset)]
        antinodes << antinode
        break if remove_boundaries.call(antinode)
      end
      grid.length.times do |n|
        antinode = [second[0] + ((n + 1) * row_offset), second[1] + ((n + 1) * col_offset)]
        antinodes << antinode
        break if remove_boundaries.call(antinode)
      end
    end
  end
  filtered_antinodes = antinodes.filter { |elem| elem unless remove_boundaries.call(elem) }
  filtered_antinodes + line # Add the antenna as antinodes too
end

list_of_all = []

antennas.each do |_key, antenna|
  list_of_all.append(find_antinodes(grid, antenna))
end

puts "All antinodes created: #{list_of_all.flatten(1).count}"
puts "Unique antinodes created: #{list_of_all.flatten(1).uniq.count}"