def containsAbba(sequence):
    for i in range(0, len(sequence) - 3):
        if sequence[i] != sequence[i + 1] and sequence[i] == sequence[i + 3] and sequence[i + 1] == sequence[i + 2]:
            return True
    return False


count = 0

with open('input') as f:
    for line in f:
        sequences = []
        hypernet_sequences = []
        current = ''
        for c in line:
            if c == '[' or c == '\n':
                if current:
                    sequences.append(current)
                current = ''
            elif c == ']':
                if current:
                    hypernet_sequences.append(current)
                current = ''
            else:
                current += c
        any(map(containsAbba, hypernet_sequences))
        if any(map(containsAbba, hypernet_sequences)):
            continue
        if any(map(containsAbba, sequences)):
            count += 1

print(count)