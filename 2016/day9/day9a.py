output = ''

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
            output += sequence*int(count)
        else:
            output += line[i]
            i += 1


print(len(output))