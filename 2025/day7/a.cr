count = 0
beams = Set(Int32).new

File.open("input.txt") do |file|
    file.each_line do |line|
        if line.includes?('S')
            beams << line.index!('S')
            next
        end
        unless line.includes?('^')
            next
        end
        new_beams = Set(Int32).new
        beams.each do |beam|
            if line[beam] == '^'
                new_beams << beam - 1
                new_beams << beam + 1
                count += 1
            else
                new_beams << beam
            end
        end
        beams = new_beams
    end
end

puts count
