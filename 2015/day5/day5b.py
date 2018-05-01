nice_counter = 0

with open('input') as f:
    for line in f:
        pair_exists = False
        for i in range(len(line) - 1):
            pair = line[i:i+2]
            
            for y in range(i + 2, len(line) - 1):
                pair2 = line[y:y+2]
                if pair == pair2:
                    pair_exists = True
                    break

            if pair_exists:
                break

        if not pair_exists:
            continue

        for i in range(len(line) - 2):
            if line[i] == line[i + 2]:
                nice_counter += 1
                break

print(nice_counter)
