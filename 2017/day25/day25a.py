one_slots = set()
cursor = 0
state = 'a'

for i in range(12317297):
    slot_is_one = cursor in one_slots
    if state == 'a':
        if not slot_is_one:
            one_slots.add(cursor)
            cursor += 1
            state = 'b'
        else:
            one_slots.remove(cursor)
            cursor -= 1
            state = 'd'
    elif state == 'b':
        if not slot_is_one:
            one_slots.add(cursor)
            cursor += 1
            state = 'c'
        else:
            one_slots.remove(cursor)
            cursor += 1
            state = 'f'
    elif state == 'c':
        if not slot_is_one:
            one_slots.add(cursor)
            cursor -= 1
            state = 'c'
        else:
            cursor -= 1
            state = 'a'
    elif state == 'd':
        if not slot_is_one:
            cursor -= 1
            state = 'e'
        else:
            cursor += 1
            state = 'a'
    elif state == 'e':
        if not slot_is_one:
            one_slots.add(cursor)
            cursor -= 1
            state = 'a'
        else:
            one_slots.remove(cursor)
            cursor += 1
            state = 'b'
    elif state == 'f':
        if not slot_is_one:
            cursor += 1
            state = 'c'
        else:
            one_slots.remove(cursor)
            cursor += 1
            state = 'e'

print(len(one_slots))