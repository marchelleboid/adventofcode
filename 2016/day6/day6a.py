import operator

letter_counters = []

first_line = True
with open('input') as f:
    for line in f:
        line = line.strip()
        for i in range(0, len(line)):
            if first_line:
                letter_counters.append({})
            character = line[i]
            letter_counter = letter_counters[i]
            if character in letter_counter:
                count = letter_counter[character] + 1
            else:
                count = 1
            letter_counter[character] = count
        first_line = False

word = []

for letter_counter in letter_counters:
    word.append(max(letter_counter.keys(), key=(lambda k: letter_counter[k])))

print("".join(word))
