def is_possible_triangle(side1, side2, side3):
    return side1 + side2 > side3 and side2 + side3 > side1 and side1 + side3 > side2

count = 0

with open('input') as f:
    for line in f:
        sides = list(map(int, line.split()))
        if is_possible_triangle(sides[0], sides[1], sides[2]):
            count += 1

print(count)
