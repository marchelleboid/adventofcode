def get_joltage(s)
    current = Array.new(12, '0')
    s.each_char_with_index do |char, index|
        current_index = 12 - (s.size - index)
        if current_index < 0
            current_index = 0
        end

        clear = false
        while current_index < 12
            if clear
                current[current_index] = '0'
            elsif char > current[current_index]
                current[current_index] = char
                clear = true
            end
            current_index += 1
        end
    end
    return current.join.to_u64
end

count = 0_u64

File.open("input.txt") do |file|
    file.each_line do |line|
        count += get_joltage(line)
    end
end

puts count
