with open('input') as f:
    line = f.readline().strip()

in_group = False
in_garbage = False
skip_next = False
garbage_count = 0

for c in line:
    if skip_next:
        skip_next = False
        continue
    if in_garbage:
        if c == '!':
            skip_next = True
        elif c == '>':
            in_garbage = False
        else:
            garbage_count += 1
    elif in_group:
        if c == '<':
            in_garbage = True
    elif c == '{':
        in_group = True
    # elif c == '<':
    #     in_garbage = True

print(garbage_count)
