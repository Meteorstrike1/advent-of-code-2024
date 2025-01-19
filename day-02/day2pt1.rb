# Spent a very long time on part 2 with many wrong answers, come back to it at somepoint
# Not sure how this solution even works for part 1 may have got lucky with dataset
file = File.readlines('inputday2', chomp: true)

def safe_increasing?(report)
  result = true
  report.each_with_index do |num, index|
    next if index == report.length - 1

    adjacent_safe = true if (report[index + 1] - num) >= 1 && (report[index + 1] - num) <= 3
    unless adjacent_safe
      result = false
      break
    end
  end
  result
end

list_of_reports = []

# calculate how many increase safely
file.each do |report|
  level = report.split(' ').map(&:to_i)
  if level[0] < level[level.length - 1]
    list_of_reports << safe_increasing?(level)
  else
    # assumes the list is decreasing and reverses it
    list_of_reports << safe_increasing?(level.reverse)
  end
end

puts list_of_reports.count(true)
