dial = 50
password = 0

File.open("input.txt") do |file|
    file.each_line do |line|
        move = line.strip[1..].to_i
        previous = dial
        if line[0] == 'R'
            dial += move
        else
            dial -= move
        end

        if dial >= 100
            password += dial // 100
        elsif dial < 0
            if previous != 0
                password += 1
            end
            password += dial // -100
        elsif dial == 0
            password += 1
        end

        dial %= 100
    end
end

puts password
