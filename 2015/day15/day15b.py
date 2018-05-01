import sys
from itertools import combinations


def partitions(n, t):
    """
    Generate the sequences of `n` positive integers that sum to `t`.
    """
    assert(1 <= n <= t)
    for c in combinations(range(1, t), n - 1):
        def intervals():
            last = 0
            for i in c:
                yield i - last
                last = i
            yield t - last
        yield list(intervals())


attributes = []

with open('input') as f:
    for line in f:
        line = line.strip()
        comma_split = line.split(", ")
        attribute = []
        for split in comma_split:
            space_split = split.split(" ")
            attribute.append(int(space_split[-1]))
        attributes.append(attribute)

combinations = list(partitions(len(attributes), 100))

max_points = 0

for combination in combinations:
    points = 1
    for k in range(0, len(attributes[0])):
        ingredient_points = [x[k] for x in attributes]
        ingredient_scores = [a*b for a,
                             b in zip(combination, ingredient_points)]
        ingredient_score = sum(ingredient_scores)
        if k == len(attributes[0]) - 1:
            if ingredient_score != 500:
                points = 0
            break
        if ingredient_score <= 0:
            points = 0
            break
        points *= ingredient_score
    if points > max_points:
        max_points = points

print(max_points)
