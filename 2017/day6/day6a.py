with open('input') as f:
    memory = list(map(int, f.readline().strip().split('\t')))

memory_length = len(memory)
already_seen = set()
counter = 0
while tuple(memory) not in already_seen:
    already_seen.add(tuple(memory))
    value = max(memory)
    index = memory.index(value)
    memory[index] = 0
    for x in range(0, value):
        index += 1
        if index == memory_length:
            index = 0
        memory[index] = memory[index] + 1
    counter += 1

print(counter)
