# Had to read up a hint to do part 1, using .pop to move the space around, couldn't manage part 2 at the time, will have to go back to it
FREE_SPACE = '.'.freeze
file = File.read('inputday9')

disk_map = file.split('')
disk_map = disk_map.map(&:to_i)

def display_file_layout(disk_map)
  output = []
  disk_map.each_with_index do |elem, index|
    if index.even?
      id = index.zero? ? 0 : (index / 2)
      elem.times { output << id }
    else
      elem.times { output << FREE_SPACE }
    end
  end
  output
end

output = display_file_layout(disk_map)


moved_space = []

output.each_with_index do |block, index|
  next unless block == FREE_SPACE
  new_block = output.pop
  new_block = output.pop while new_block == FREE_SPACE
  output[index] = new_block
  moved_space << FREE_SPACE
end

output = output + moved_space

def calculate_checksum(file)
  checksum = []
  file.each_with_index do |id, pos|
    next if id == FREE_SPACE
    checksum << (id * pos)
  end
  checksum.reduce(:+)
end

puts "Part 1: #{calculate_checksum(output)}"
