def supportsSsl(sequence, hypernet_sequences):
    for i in range(0, len(sequence) - 2):
        if sequence[i] != sequence[i + 1] and sequence[i] == sequence[i + 2]:
            bab = sequence[i + 1] + sequence[i] + sequence[i + 1]
            for hypernet_sequence in hypernet_sequences:
                if bab in hypernet_sequence:
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
        for sequence in sequences:
            if supportsSsl(sequence, hypernet_sequences):
                count += 1
                break

print(count)