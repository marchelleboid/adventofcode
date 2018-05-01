lengths = [165, 1, 255, 31, 87, 52, 24, 113, 0, 91, 148, 254, 158, 2, 73, 153]
numbers = list(range(0, 256))

current_position = 0
skip_size = 0

for length in lengths:
    list_to_reverse = numbers[current_position:current_position + length]
    missing_length = length - len(list_to_reverse)
    list_to_reverse += numbers[0:missing_length]
    reversed_list = list_to_reverse[::-1]
    for i in reversed_list:
        numbers[current_position] = i
        current_position = (current_position + 1) % 256
    current_position = (current_position + skip_size) % 256
    skip_size += 1

print(numbers[0] * numbers[1])
