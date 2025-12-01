dial = 50
password = 0

File.open("input.txt") do |file|
    file.each_line do |line|
        move = line.strip[1..].to_i
        if line[0] == 'R'
            dial += move
        else
            dial -= move
        end
        dial %= 100
        if dial == 0
            password += 1
        end
    end
end

puts password
