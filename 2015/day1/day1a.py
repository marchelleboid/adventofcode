floor = 0

with open('input') as f:
    line = f.readline()
    for x in line:
        if x == "(":
            floor += 1
        elif x == ")":
            floor -= 1

print(floor)
