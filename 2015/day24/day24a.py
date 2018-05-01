import itertools
import sys

with open('input') as f:
    packages = [int(line.strip()) for line in f.readlines()]

GROUPS_OF_PACKAGES = 3

total_weight = sum(packages)
group_weight = int(total_weight/GROUPS_OF_PACKAGES)

def can_split_remaining_packages(remaining_packages):
    for x in range(1, len(remaining_packages)):
        for combination in itertools.combinations(remaining_packages, x):
            if sum(combination) == group_weight:
                return True
    return False

def find_qe(group):
    r = 1
    for x in group:
        r *= x
    return r

group_size = -1
lowest_qe = 999999999999999999999

for x in range(1, len(packages)):
    for combination in itertools.combinations(packages, x):
        if sum(combination) == group_weight:
            remaining_packages = [x for x in packages if x not in combination]
            if can_split_remaining_packages(remaining_packages):
                group_size = x
                qe = find_qe(list(combination))
                if qe < lowest_qe:
                    lowest_qe = qe

    if group_size != -1:
        break

print(lowest_qe)
