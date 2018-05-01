sums = 0

with open('input') as f:
    line = f.readline()
    for i in range(int(len(line)/2)):
        if line[i] == line[i + int(len(line)/2)]:
            sums += int(line[i])

print(sums * 2)
