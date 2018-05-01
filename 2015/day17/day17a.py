import itertools

EGGNOG = 150
containers = []

with open('input') as f:
    for line in f:
        containers.append(int(line.strip()))

combinations = 0

for x in range(1, len(containers) + 1):
    for combination in itertools.combinations(containers, x):
        if sum(combination) == EGGNOG:
            combinations += 1

print(combinations)