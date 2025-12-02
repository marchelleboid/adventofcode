def is_silly?(s)
    if s.size < 2
        return false
    end
    group_size = 1
    while group_size <= s.size // 2
        groups = s.chars.in_groups_of(group_size).map do |chunk|
            chunk.compact.join
        end
        if groups.all? { |x| x == groups[0] }
            return true
        end
        group_size += 1
    end
    return false
end

line = File.read_lines("input.txt", chomp: true)[0]

count = 0_u64

line.split(',').each do |range|
    limits = range.split('-')
    current = limits[0].to_u64
    last = limits[1].to_u64
    while current <= last
        current_as_string = current.to_s
        if is_silly?(current_as_string)
            count += current
        end
        current += 1
    end
end

puts count
