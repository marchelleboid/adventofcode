visited = set()

(x, y) = (0, 0)
visited.add((x, y))

with open('input') as f:
    input = f.readline()
    for char in input:
        if char == "^":
            y += 1
        elif char == ">":
            x += 1
        elif char == "v":
            y -= 1
        elif char == "<":
            x -= 1
        visited.add((x, y))

print(len(visited))
