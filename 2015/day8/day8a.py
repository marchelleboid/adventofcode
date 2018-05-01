total_characters = 0
string_characters = 0

with open('input') as f:
    for line in f:
        line = line.strip()
        total_characters += len(line)
        i = 0
        r = 0
        while i < len(line):
            r += 1
            if line[i] == "\\":
                if line[i + 1] == "x":
                    i += 4
                else:
                    i += 2
            else:
                i += 1
        string_characters += r - 2

print(total_characters - string_characters)