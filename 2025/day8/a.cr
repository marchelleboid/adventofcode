def distance(p1, p2)
    return Math.sqrt((p1[0] - p2[0]) ** 2 + (p1[1] - p2[1]) ** 2 + (p1[2] - p2[2]) ** 2)
end

points = Array({Int64, Int64, Int64}).new

File.open("input.txt") do |file|
    file.each_line do |line|
        split_line = line.split(',')
        points << {split_line[0].to_i64, split_line[1].to_i64, split_line[2].to_i64}
    end
end

distances = Array({Int32, Int32, Float64}).new

i = 0
while i < points.size
    j = i + 1
    while j < points.size
        distances << {i, j, distance(points[i], points[j])}
        j += 1
    end
    i += 1
end

sorted_distances = (distances.sort_by { |x| x[2] })[0..999]

circuits = Array(Set(Int32)).new

sorted_distances.each do |pair|
    p0_in_circuit = false
    p0_circuit = Set(Int32).new
    p1_in_circuit = false
    p1_circuit = Set(Int32).new

    circuits.each do |circuit|
        if circuit.includes?(pair[0])
            p0_in_circuit = true
            p0_circuit = circuit
        end
        if circuit.includes?(pair[1])
            p1_in_circuit = true
            p1_circuit = circuit
        end
        if p0_in_circuit && p1_in_circuit
            break
        end
    end

    if p0_in_circuit && p1_in_circuit
        new_circuit = p0_circuit + p1_circuit
        circuits.delete(p0_circuit)
        circuits.delete(p1_circuit)
        circuits << new_circuit
    elsif p0_in_circuit && !p1_in_circuit
        p0_circuit << pair[1]
    elsif !p0_in_circuit && p1_in_circuit
        p1_circuit << pair[0]
    else
        circuits << Set{pair[0], pair[1]}
    end
end

sorted_circuits = ((circuits.map { |circuit| circuit.size }).sort { |a, b| b <=> a } )[0..2]

puts sorted_circuits.reduce(1) { |acc, n| acc * n }
