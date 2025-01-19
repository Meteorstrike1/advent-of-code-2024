# Didn't need to alter much for part 2 but this does run VERY slowly, takes a few minutes
MORE_OPERATORS = %w[+ * <<].freeze

read_file = IO.readlines('inputday7')

list_ready = read_file.map do |line|
  test_value = line.scan(/(^\d+):/)
  rest = line.scan(/ (\d+)/).flatten
  {test_value: test_value.join.to_i, rest: rest}
end

def process_line(line)
  values = line[:rest]
  num = line[:rest].length - 1
  pos_ops = MORE_OPERATORS.repeated_permutation(num).to_a
  pos_ops.each do |pos_op|
    if calculate(pos_op, values) == line[:test_value]
      return line[:test_value]
    end
  end
  0
end

def calculate(pos_op, values)
  total = values[0]
  values.each_with_index do |_value, index|
    if index == values.length - 1
      return total
    end
    if pos_op[index] == '<<'
      total = "#{total}#{values[index + 1]}".to_i
    else
      total = eval(total.to_s + pos_op[index] + values[index + 1])
    end
  end
end

results = list_ready.map do |line|
  process_line(line)
end

puts results.reduce(:+)
