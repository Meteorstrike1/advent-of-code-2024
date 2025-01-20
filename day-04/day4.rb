# Had a go at this today from scratch
matrix = File.readlines('inputday4', chomp: true).map(&:chars)
SEARCH_WORD = 'XMAS'.freeze
DIRECTIONS = [0, 1, -1].repeated_permutation(2).to_a
DIRECTIONS.shift # I know modifying a constant is really bad, want to get rid of [0,0], (ah I could have used reject)

NEXT_CO_ORDS = {
  [0, 1] => [[0, 2], [0, 3]],
  [0, -1] => [[0, -2], [0, -3]],
  [1, 0] => [[2, 0], [3, 0]],
  [1, 1] => [[2, 2], [3, 3]],
  [1, -1] => [[2, -2], [3, -3]],
  [-1, 0] => [[-2, 0], [-3, 0]],
  [-1, 1] => [[-2, 2], [-3, 3]],
  [-1, -1] => [[-2, -2], [-3, -3]]
}.freeze

def out_of_bounds?(matrix, x, y)
  max_x = matrix[0].length - 1
  max_y = matrix.length - 1
  x > max_x || x < 0 || y > max_y || y < 0
end

# Part 1
def co_ord(direction, x_i, y_i)
  second, third = NEXT_CO_ORDS[direction]
  [x_i + direction[0], y_i + direction[1], x_i + second[0], y_i + second[1], x_i + third[0], y_i + third[1]]
end

count = 0

matrix.each_with_index do |row, y_i|
  row.each_with_index do |col, x_i|
    next unless col == SEARCH_WORD[0]
    DIRECTIONS.each do |direction|
      x, y, x_2, y_2, x_3, y_3 = co_ord(direction, x_i, y_i)
      unless out_of_bounds?(matrix, x_3, y_3)
        if matrix[y][x] == SEARCH_WORD[1] && matrix[y_2][x_2] == SEARCH_WORD[2] && matrix[y_3][x_3] == SEARCH_WORD[3]
          count += 1
        end
      end
    end
  end
end

puts "Part 1: #{count}"

# Part 2
def x_mas?(matrix, x_i, y_i)
  if out_of_bounds?(matrix, x_i - 1, y_i - 1) || out_of_bounds?(matrix, x_i + 1, y_i + 1)
    return false
  end
  # top left and bottom right
  tlbr = matrix[y_i - 1][x_i - 1] == 'M' && matrix[y_i + 1][x_i + 1] == 'S' || matrix[y_i - 1][x_i - 1] == 'S' && matrix[y_i + 1][x_i + 1] == 'M'
  # top right and bottom left
  trbl = matrix[y_i - 1][x_i + 1] == 'M' && matrix[y_i + 1][x_i - 1] == 'S' || matrix[y_i - 1][x_i + 1] == 'S' && matrix[y_i + 1][x_i - 1] == 'M'
  tlbr && trbl
end

part2_count = 0

matrix.each_with_index do |row, y_i|
  row.each_with_index do |col, x_i|
    next unless col == 'A'
    if x_mas?(matrix, x_i, y_i)
      part2_count += 1
    end
  end
end

puts "Part 2: #{part2_count}"
