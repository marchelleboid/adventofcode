differences = []

with open('input') as f:
    for line in f:
        values = list(map(int, line.split()))
        differences.append(max(values) - min(values))

print(sum(differences))