a_value = 516
b_value = 190

judge_count = 0

for i in range(5000000):
    while True:
        a_value = (a_value * 16807) % 2147483647
        if a_value % 4 == 0:
            break
    while True:
        b_value = (b_value * 48271) % 2147483647
        if b_value % 8 == 0:
            break
    if (a_value & 0xffff) == (b_value & 0xffff):
        judge_count += 1

print(judge_count)
