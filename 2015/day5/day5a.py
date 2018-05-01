nice_counter = 0

with open('input') as f:
    for line in f:
        if "ab" in line or "cd" in line or "pq" in line or "xy" in line:
            continue
        vowel_counter = 0
        for x in line:
            if x in "aeiou":
                vowel_counter += 1
        if vowel_counter < 3:
            continue
        for i in range(len(line) - 1):
            if line[i] == line[i + 1]:
                nice_counter += 1
                break

print(nice_counter)