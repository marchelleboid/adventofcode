total = 0

with open('input') as f:
    for line in f:
        (l, w, h) = line.split("x")
        side1 = int(l)*int(w)
        side2 = int(w)*int(h)
        side3 = int(l)*int(h)
        total += 2*side1 + 2*side2 + 2*side3
        total += min(side1, side2, side3)

print(total)
