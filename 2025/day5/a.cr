ranges = Set({UInt64, UInt64}).new

count = 0
File.open("input.txt") do |file|
    first_part = true
    file.each_line do |line|
        if line.empty?
            first_part = false
            next
        end

        if first_part
            split_line = line.split('-')
            ranges << { split_line[0].to_u64, split_line[1].to_u64 }
            next
        end

        ingredient = line.to_u64

        ranges.each do |r|
            if ingredient >= r[0] && ingredient <= r[1]
                count += 1
                break
            end
        end
    end
end

puts count
