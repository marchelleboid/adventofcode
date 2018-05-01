steps = 349
current_position = 0
after_zero = 0

for i in range(1, 50000001):
    current_position += steps
    current_position %= i
    current_position += 1
    if current_position == 1:
        after_zero = i

print(after_zero)
