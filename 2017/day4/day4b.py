import itertools

def anagramsExist(x):
    for a, b in itertools.combinations(x, 2):
        if sorted(a) == sorted(b):
            return True
    return False

with open('input') as f:
    lines = f.readlines()
    print(len(list(filter(lambda x: not anagramsExist(x), map(lambda x: x.strip().split(' '), lines)))))