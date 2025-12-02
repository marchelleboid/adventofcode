line = File.read_lines("input.txt", chomp: true)[0]

count = 0_u64

line.split(',').each do |range|
    limits = range.split('-')
    current = limits[0].to_u64
    last = limits[1].to_u64
    while current <= last
        current_as_string = current.to_s
        if current_as_string.size % 2 == 0
            if current_as_string[0, current_as_string.size // 2] == current_as_string[current_as_string.size // 2, current_as_string.size // 2]
                count += current
            end
        end
        current += 1
    end
end

puts count
