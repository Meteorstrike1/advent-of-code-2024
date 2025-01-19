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

def find_antinodes(grid, line)
  remove_boundaries = -> (elem) { elem[0] < 0 || elem[0] > grid.length - 1 || elem[1] < 0 || elem[1] > grid.length - 1 }
  if line.count < 2
    0
  end
  combos = line.combination(2).to_a
  antinodes = []
  combos.each do |first, second|
    row_offset, col_offset = compare_distance(first, second)
    if first[1] >= second[1]
      antinodes << [first[0] - row_offset, first[1] + col_offset]
      antinodes << [second[0] + row_offset, second[1] - col_offset]
    else
      antinodes << [first[0] - row_offset, first[1] - col_offset]
      antinodes << [second[0] + row_offset, second[1] + col_offset]
    end
  end
  antinodes.filter { |elem| elem unless remove_boundaries.call(elem) }
end

list_of_all = []

antennas.each do |_key, antenna|
  list_of_all.append(find_antinodes(grid, antenna))
end

puts "All antinodes created: #{list_of_all.flatten(1).count}"
puts "Unique antinodes created: #{list_of_all.flatten(1).uniq.count}"