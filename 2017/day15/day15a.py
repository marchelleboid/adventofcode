a_value = 516
b_value = 190

judge_count = 0

for i in range(40000000):
    a_value = (a_value * 16807) % 2147483647
    b_value = (b_value * 48271) % 2147483647
    if (a_value & 0xffff) == (b_value & 0xffff):
        judge_count += 1

print(judge_count)
