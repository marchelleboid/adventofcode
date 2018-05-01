from math import sqrt
from math import ceil

def find_factors(n):
    factors = set()
    for x in range(1, int(sqrt(n)) + 1):
        if n % x == 0:
            factors.add(x)
            factors.add(int(n / x))
    return list(filter((lambda x: x * 50 >= n), list(factors)))

limit = 34000000

x = 1

while True:
    factors = find_factors(x)
    presents = sum(map((lambda x : 11*x), factors))
    if presents >= limit:
        print(x)
        break
    x += 1