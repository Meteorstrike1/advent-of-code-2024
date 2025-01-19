# Didn't have time to look at day 5 at the time, came back to it today
file = File.readlines('inputday5', chomp: true)

section_divide = false
page_rules = Hash.new([]) # Default value to make part 2 easier
updates = []

# Parse the file into page rules and updates
file.each do |line|
  if line == ''
    section_divide = true
    next
  end
  if section_divide
    updates << line.split(',').map(&:to_i)
  else
    nums = line.split('|')
    before = nums[0].to_i
    after = nums[1].to_i
    if page_rules.keys.include?(before)
      page_rules[before] << after
    else
      page_rules[before] = [after]
    end
  end
end

def correct_order?(update, page_rules)
  update.each_with_index do |page, index|
    next unless page_rules.keys.include?(page)
    after_pages = page_rules[page]
    after_pages.each do |after_page|
      next unless update.include?(after_page)
      unless index < update.index(after_page)
        return false
      end
    end
  end
  true
end

# Part 1
printed_updates = updates.filter_map do |update|
  if correct_order?(update, page_rules)
    update
  end
end

middle_pages = printed_updates.filter_map do |printed|
  printed[printed.length / 2]
end

puts "Part 1: #{middle_pages.reduce(:+)}"

# Part 2
incorrectly_ordered = updates.filter_map do |update|
  unless correct_order?(update, page_rules)
    update
  end
end

def reorder(update, page_rules)
  update.each_with_index do |page, index|
    next unless page_rules.keys.include?(page)
    next unless index != 0
    if page_rules[page].include?(update[index - 1])
      to_swap = update[index - 1]
      update[index] = to_swap
      update[index - 1] = page
    end
  end
  if correct_order?(update, page_rules)
    update
  else
    reorder(update, page_rules)
  end
end

reordered = incorrectly_ordered.map do |update|
  reorder(update, page_rules)
end

reordered_middle_pages = reordered.filter_map do |printed|
  printed[printed.length / 2]
end

puts "Part 2: #{reordered_middle_pages.reduce(:+)}"
