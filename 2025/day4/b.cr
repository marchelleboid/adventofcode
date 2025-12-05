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

while true
    to_remove = Set({Int32, Int32}).new
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
            to_remove << {x, y}
        end
    end

    if to_remove.empty?
        break
    end

    count += to_remove.size
    rolls = rolls - to_remove
end

puts count
