inputs = Array(Array(String)).new

File.open("input.txt") do |file|
    file.each_line do |line|
        inputs << line.strip.split()
    end
end

count = 0_u64

i = 0
while i < inputs[0].size
    values = Array(UInt64).new
    inputs.each do |input|
        v = input[i]
        if v == "*"
            count += values.reduce(1_u64) { |acc, i| acc * i }
        elsif v == "+"
            count += values.sum
        else
            values << v.to_u64
        end
    end
    i += 1
end

puts count
