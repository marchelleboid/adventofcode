ranges = [] of {UInt64, UInt64}
File.open("input.txt") do |file|
    file.each_line do |line|
        if line.empty?
            break
        end

        split_line = line.split('-')
        ranges << { split_line[0].to_u64, split_line[1].to_u64 }
    end
end

ranges = ranges.sort_by do |r|
    r[0]
end

merged_ranges = Set({UInt64, UInt64}).new
ranges.each do |r|
    smallest = r
    largest = r
    merged_ranges.each do |mr|
        if r[0] >= mr[0] && r[0] <= mr[1]
            smallest = mr
        end
        if r[1] <= mr[1] && r[1] >= mr[0]
            largest = mr
        end
        if smallest != r && largest != r
            break
        end
    end

    merged_ranges.delete(smallest)
    merged_ranges.delete(largest)

    merged_ranges << {smallest[0], largest[1]}
end

count = 0_u64
merged_ranges.each do |r|
    count += (r[1] - r[0] + 1)
end
puts count
