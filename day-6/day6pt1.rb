OBSTACLE = '#'.freeze
CLEAR = '.'.freeze
START = '^'.freeze

grid = File.readlines('inputday6', chomp: true).map(&:chars)

def start_position(grid)
  grid.each_with_index do |row, row_i|
    if row.find_index(START)
      return [row_i, row.find_index(START)]
    end
  end
end

start = start_position(grid)
grid[start[0]][start[1]] = CLEAR

def move_with_direction(grid, row_num, col_num, direction_facing)
  if direction_facing == :up
    if (row_num - 1) <= 0 && grid[row_num - 1][col_num] != OBSTACLE
      [row_num, col_num, :finished]
    elsif grid[row_num - 1][col_num] == CLEAR
      return [row_num - 1, col_num, :up]
    else
      move_with_direction(grid, row_num, col_num, :right)
    end
  elsif direction_facing == :right
    if (col_num + 1) >= grid[0].size && grid[row_num][col_num + 1] != OBSTACLE
      [row_num, col_num, :finished]
    elsif grid[row_num][col_num + 1] == CLEAR
      return [row_num, col_num + 1, :right]
    else
      move_with_direction(grid, row_num, col_num, :down)
    end
  elsif direction_facing == :down
    if (row_num + 1) >= grid.size && grid[row_num + 1][col_num] != OBSTACLE
      [row_num, col_num, :finished]
    elsif grid[row_num + 1][col_num] == CLEAR
      return [row_num + 1, col_num, :down]
    else
      move_with_direction(grid, row_num, col_num, :left)
    end
  elsif direction_facing == :left
    if (col_num - 1) <= 0 && grid[row_num][col_num - 1] != OBSTACLE
      [row_num, col_num, :finished]
    elsif grid[row_num][col_num - 1] == CLEAR
      return [row_num, col_num - 1, :left]
    else
      move_with_direction(grid, row_num, col_num, :up)
    end
  end
end

in_map = true
current_pos = start
current_dir = :up
positions = [start]

while in_map
  row_num = current_pos[0]
  col_num = current_pos[1]
  begin
    if current_dir == :finished
      in_map = false
    end
    next_row, next_col, next_direction = move_with_direction(grid, row_num, col_num, current_dir)
    current_pos = [next_row, next_col]
    current_dir = next_direction
    positions << current_pos
  rescue NoMethodError
    in_map = false
  end
end

puts "Total positions visited: #{positions.length}"
puts "Total distinct positions visited: #{positions.uniq.length}"
