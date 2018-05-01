sums = 0

with open('input') as f:
    line = f.readline()
    for i in range(len(line) - 2):
        if line[i] == line[i + 1]:
            sums += int(line[i])

    if line[-1] == line[0]:
        sums += int(line[0])

print(sums)