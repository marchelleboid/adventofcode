beams = Hash(Int32, UInt64).new(0_u64)

File.open("input.txt") do |file|
    file.each_line do |line|
        if line.includes?('S')
            beams[line.index!('S')] = 1_u64
            next
        end
        unless line.includes?('^')
            next
        end
        new_beams = Hash(Int32, UInt64).new(0_u64)
        beams.each do |pos, count|
            if line[pos] == '^'
                new_beams.update(pos - 1) { |v| v + count }
                new_beams.update(pos + 1) { |v| v + count }
            else
                new_beams.update(pos) { |v| v + count }
            end
        end
        beams = new_beams
    end
end

puts beams.values.sum
