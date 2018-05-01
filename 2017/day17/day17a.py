steps = 349
buffer = [0]
current_position = 0

for i in range(1, 2018):
    current_position += steps
    current_position %= len(buffer)
    current_position += 1
    buffer.insert(current_position, i)

print(buffer[current_position + 1])