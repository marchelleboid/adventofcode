with open('input') as f:
    line = f.readline().strip()

total_score = 0
current_score = 0
in_group = False
in_garbage = False
skip_next = False

for c in line:
    if skip_next:
        skip_next = False
        continue
    if in_garbage:
        if c == '!':
            skip_next = True
        elif c == '>':
            in_garbage = False
    elif in_group:
        if c == '{':
            current_score += 1
        elif c == '}':
            total_score += current_score
            current_score -= 1
        elif c == '<':
            in_garbage = True
    elif c == '{':
        current_score += 1
        in_group = True
    # elif c == '<':
    #     in_garbage = True

print(total_score)