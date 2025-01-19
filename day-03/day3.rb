# Sure could simplify this one quite a bit (did have to do a bit of debugging in part 2) but enjoyed it and felt more intuitive
read_file = File.read(filename = 'inputday3')
# Carry out the instructions
int_and_multiply = proc { |n, m| (n.to_i * m.to_i) }

# Part 1
def extract_mul(line)
  line.scan(/mul\(\d{1,3},\d+{1,3}\)/)
end

extracted_muls = extract_mul(read_file)
list_of_values = []

extracted_muls.each do |mul|
  values = mul.scan(/\d{1,3}/)
  list_of_values << int_and_multiply.call(*values)
end

puts "Part 1: #{list_of_values.reduce(:+)}"

# Part 2
def extract_instructions(file)
  file.scan(/don\'t\(\)|do\(\)|mul\(\d{1,3},\d+{1,3}\)/)
end

extracted_instructions = extract_instructions(read_file)
flattened_instructions = extracted_instructions.flatten

list_valids = []
list_invalids = []
accept = true
do_list = []
dont_list = []

flattened_instructions.each do |instruction|
  if instruction =~ /mul\(\d{1,3},\d+{1,3}\)/
    if accept
      list_valids << instruction
    else
      list_invalids << instruction
    end
  else
    if instruction =~ /don\'t\(\)?/
      accept = false
      dont_list << instruction
    elsif instruction =~ /do\(\)/
      accept = true
      do_list << instruction
    else
      puts instruction
    end
  end
end

list_part2 = []

list_valids.each do |mul|
  values = mul.scan(/\d{1,3}/)
  list_part2 << int_and_multiply.call(*values)
end

puts "Part 2: #{list_part2.reduce(:+)}"
