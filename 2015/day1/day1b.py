floor = 0
count = 0

with open('input') as f:
    line = f.readline()
    for x in line:
        count += 1
        if x == "(":
            floor += 1
        elif x == ")":
            floor -= 1
        if floor == -1:
            print(count)
            break
