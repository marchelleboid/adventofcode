total = 0

with open('input') as f:
    for line in f:
        (l, w, h) = line.split("x")
        total += 2*min(int(l) + int(w), int(w) + int(h), int(l) + int(h))
        total += int(l)*int(w)*int(h)

print(total)
