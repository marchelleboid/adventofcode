def get_joltage(s)
    first = '0'
    second = '0'
    s.each_char_with_index do |char, index|
        if index != s.size - 1
            if char > first
                first = char
                second = '0'
            elsif char > second
                second = char
            end
        else
            if char > second
                second = char
            end
        end
    end
    return "#{first}#{second}".to_i
end

count = 0

File.open("input.txt") do |file|
    file.each_line do |line|
        count += get_joltage(line)
    end
end

puts count
