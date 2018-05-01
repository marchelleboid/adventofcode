def is_possible_triangle(side1, side2, side3):
    return side1 + side2 > side3 and side2 + side3 > side1 and side1 + side3 > side2

count = 0

triangle0 = []
triangle1 = []
triangle2 = []

with open('input') as f:
    for line in f:
        sides = list(map(int, line.split()))
        triangle0.append(sides[0])
        triangle1.append(sides[1])
        triangle2.append(sides[2])
        if len(triangle0) == 3:
            if is_possible_triangle(triangle0[0], triangle0[1], triangle0[2]):
                count += 1
            if is_possible_triangle(triangle1[0], triangle1[1], triangle1[2]):
                count += 1
            if is_possible_triangle(triangle2[0], triangle2[1], triangle2[2]):
                count += 1
            triangle0 = []
            triangle1 = []
            triangle2 = []

print(count)
