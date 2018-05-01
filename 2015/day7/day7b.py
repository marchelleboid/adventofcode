def is_int(s):
    try:
        int(s)
        return True
    except ValueError:
        return False

wires = {}
with open('input2') as f:
    lines = f.readlines()
    while len(lines) > 0:
        for line in list(lines):
            line_evaluated = False
            (value, wire) = line.split(" -> ")
            wire = wire.strip()
            if is_int(value):
                wires[wire] = int(value)
                line_evaluated = True
            else:
                split_line = value.split(" ")
                length = len(split_line)
                if length == 1:
                    if split_line[0] in wires:
                        wires[wire] = wires[split_line[0]]
                        line_evaluated = True
                elif length == 2:
                    if split_line[0] != 'NOT':
                        print("AHH")
                    if split_line[1] in wires:
                        wires[wire] = 65535 - wires[split_line[1]]
                        line_evaluated = True
                elif length == 3:
                    (left_side, gate, right_side) = split_line
                    if gate == "AND":
                        if is_int(left_side) and right_side in wires:
                            wires[wire] = int(left_side) & wires[right_side]
                            line_evaluated = True
                        elif left_side in wires and right_side in wires:
                            wires[wire] = wires[left_side] & wires[right_side]
                            line_evaluated = True
                    elif gate == "OR":
                        if left_side in wires and right_side in wires:
                            wires[wire] = wires[left_side] | wires[right_side]
                            line_evaluated = True
                    elif gate == "LSHIFT":
                        if left_side in wires:
                            wires[wire] = wires[left_side] << int(
                                right_side) & 65535
                            line_evaluated = True
                    elif gate == "RSHIFT":
                        if left_side in wires:
                            wires[wire] = wires[left_side] >> int(right_side)
                            line_evaluated = True
                    else:
                        print("GAHHH")
                else:
                    print("OH NO")

            if line_evaluated:
                lines.remove(line)

print(wires["a"])
