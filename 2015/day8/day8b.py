total_characters = 0
encoded_characters = 0

with open('input') as f:
    for line in f:
        line = line.strip()
        total_characters += len(line)
        r = 0
        for c in line:
            if c == "\"" or c == "\\":
                r += 2
            else:
                r += 1
        encoded_characters  += r + 2

print(encoded_characters - total_characters)
