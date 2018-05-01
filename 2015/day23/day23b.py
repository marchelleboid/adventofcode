import time

with open('input') as f:
    lines = f.readlines()
    lines = list(map(lambda x: x.strip(), lines))

instruction_pointer = 0
a = 1
b = 0

while True:
    if instruction_pointer >= len(lines):
        break

    line = lines[instruction_pointer]
    instruction = line.split(" ")[0]

    if instruction == "hlf":
        register = line.split(" ")[1]
        if register == "a":
            a = int(a/2)
        else:
            b = int(b/2)
        instruction_pointer += 1
    elif instruction == "tpl":
        register = line.split(" ")[1]
        if register == "a":
            a = a*3
        else:
            b = b*3
        instruction_pointer += 1
    elif instruction == "inc":
        register = line.split(" ")[1]
        if register == "a":
            a = a + 1
        else:
            b = b + 1
        instruction_pointer += 1
    elif instruction == "jmp":
        value = int(line.split(" ")[1])
        instruction_pointer += value
    elif instruction == "jie":
        register = line.split(" ")[1]
        jump_value = int(line.split(" ")[2])
        value = a if "a" in register else b
        if value % 2 == 0:
            instruction_pointer += jump_value
        else:
            instruction_pointer += 1
    elif instruction == "jio":
        register = line.split(" ")[1]
        jump_value = int(line.split(" ")[2])
        value = a if "a" in register else b
        if value == 1:
            instruction_pointer += jump_value
        else:
            instruction_pointer += 1
    else:
        break

print(b)
