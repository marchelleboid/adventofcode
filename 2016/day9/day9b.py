global_count = 0

def decompress_sequence(sequence):
    inner_count = 0
    i = 0
    while i < len(sequence):
        if sequence[i] == '(':
            code = ''
            i += 1
            while True:
                if sequence[i] == ')':
                    i += 1
                    break
                else:
                    code += sequence[i]
                    i += 1
            characters, count = code.split('x')
            sequence2 = ''
            for x in range(0, int(characters)):
                sequence2 += sequence[i]
                i += 1
            inner_count += decompress_sequence(sequence2)*int(count)
        else:
            inner_count += 1
            i += 1
    return inner_count

with open('input') as f:
    line = f.readline()
    i = 0
    while i < len(line):
        if line[i] == '(':
            code = ''
            i += 1
            while True:
                if line[i] == ')':
                    i += 1
                    break
                else:
                    code += line[i]
                    i += 1
            characters, count = code.split('x')
            sequence = ''
            for x in range(0, int(characters)):
                sequence += line[i]
                i += 1
            global_count += decompress_sequence(sequence)*int(count)
        else:
            global_count += 1
            i += 1


print(global_count)