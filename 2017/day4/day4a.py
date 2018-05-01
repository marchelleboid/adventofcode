with open('input') as f:
    lines = f.readlines()
    print(len(list(filter(lambda x: len(x) == len(set(x)), map(lambda x: x.strip().split(' '), lines)))))