rolls = Set({Int32, Int32}).new

File.open("input.txt") do |file|
    row = 0
    file.each_line do |line|
        line.each_char_with_index do |char, index|
            if char == '@'
                rolls << {index, row}
            end
        end
        row += 1
    end
end

count = 0
rolls.each do |element|
    x = element[0]
    y = element[1]
    neighbors = 0
    if rolls.includes?({x - 1, y - 1})
        neighbors += 1
    end
    if rolls.includes?({x, y - 1})
        neighbors += 1
    end
    if rolls.includes?({x + 1, y - 1})
        neighbors += 1
    end
    if rolls.includes?({x - 1, y})
        neighbors += 1
    end
    if rolls.includes?({x + 1, y})
        neighbors += 1
    end
    if rolls.includes?({x - 1, y + 1})
        neighbors += 1
    end
    if rolls.includes?({x, y + 1})
        neighbors += 1
    end
    if rolls.includes?({x + 1, y + 1})
        neighbors += 1
    end
    if neighbors < 4
        count += 1
    end
end

puts count
