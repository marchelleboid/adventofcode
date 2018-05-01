a = 1
b = 109900
c = 126900
g = 0
h = 0

while True: # 1000 times
    d = 2
    flag = False
    condition2 = True
    while condition2: # b - 2 times
        e = d
        condition1 = True
        while condition1: # b - 2 times
            g = d*e - b
            if g == 0:
                flag = True
                break
            if g > 0:
                break
            e += 1
            g = e - b
            condition1 = g != 0
        d += 1
        if flag:
            break
        if d*d > b:
            break
        g = d - b
        condition2 = g != 0
    if flag:
        h += 1
    g = b - c
    if g == 0:
        break
    b += 17

print(h)