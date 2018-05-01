divisions = []

with open('input') as f:
    for line in f:
        values = list(map(int, line.split()))
        for value in values:
            divisible_element = [x for x in values if x != value and x % value == 0]
            if len(divisible_element) > 0:
                divisions.append(divisible_element[0] / value)

print(sum(divisions))