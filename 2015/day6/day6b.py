light_grid = [[0 for x in range(1000)] for x in range(1000)]

with open('input') as f:
    for line in f:
        cool_line = line.replace("turn", "").strip()
        (command, start, blah, end) = cool_line.split(" ")

        start_x = int(start.split(",")[0])
        start_y = int(start.split(",")[1])
        end_x = int(end.split(",")[0])
        end_y = int(end.split(",")[1])

        for x in range(start_x, end_x + 1):
            for y in range(start_y, end_y + 1):
                if command == "toggle":
                    light_grid[x][y] = light_grid[x][y] + 2
                elif command == "on":
                    light_grid[x][y] = light_grid[x][y] + 1
                elif command == "off":
                    light_grid[x][y] = max(light_grid[x][y] - 1, 0)

count = 0
for y in light_grid:
    count += sum(y)
print(count)
