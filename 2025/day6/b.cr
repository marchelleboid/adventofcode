inputs = Array(String).new

File.open("input.txt") do |file|
    file.each_line do |line|
        inputs << line
    end
end

def perform_operation(lines, op, start, stop)
    i = start
    values = Array(UInt64).new
    while i <= stop
        n = ""
        lines.each do |line|
            n += line[i]
        end
        values << n.to_u64
        i += 1
    end
    if op == '*'
        return values.reduce(1_u64) { |acc, i| acc * i }
    else
        return values.sum
    end
end

count = 0_u64

operators = inputs.pop
current_operator = ' '
start = -1
stop = -1
operators.each_char_with_index do |char, index|
    if char == '*' || char == '+'
        if start == -1
            start = index
            current_operator = char
        else
            stop = index
        end
    end

    if stop != -1
        count += perform_operation(inputs, current_operator, start, stop - 2)
        start = stop
        stop = -1
        current_operator = char
    end
end

count += perform_operation(inputs, current_operator, start, operators.size - 1)

puts count
