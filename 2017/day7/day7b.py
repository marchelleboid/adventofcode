from statistics import mode

programs = {}
program_weights = {}
root = 'xegshds'


def calculate_weights(program):
    p_weight = programs[program][0]
    p_children = programs[program][1]
    if p_children:
        total_weight = p_weight + sum(map(calculate_weights, p_children))
    else:
        total_weight = p_weight
    program_weights[program] = total_weight
    return total_weight


def all_same(items):
    return all(x == items[0] for x in items)


def find_fault(program, parent):
    p_children = programs[program][1]
    p_children_weights = list(map(lambda x: program_weights[x], p_children))
    if all_same(p_children_weights):
        p_total_weight = program_weights[program]
        p_weight = programs[program][0]
        p_siblings = list(filter(lambda x: x != program, programs[parent][1]))
        expected_weight = program_weights[p_siblings[0]]
        difference = expected_weight - p_total_weight
        print(p_weight + difference)
    else:
        if len(p_children) == 1:
            find_fault(p_children[0], program)
        if len(p_children) == 2:
            p_children0_weights = list(map(lambda x: program_weights[x], programs[p_children[0]][1]))
            if all_same(p_children0_weights):
                find_fault(p_children[1], program)
            else:
                find_fault(p_children[0], program)
        else:
            correct_weight = mode(p_children_weights)
            bad_child = list(filter(lambda x: program_weights[x] != correct_weight, p_children))[0]
            find_fault(bad_child, program)


with open('input') as f:
    for line in f:
        line = line.strip().split(' ')
        name = line[0]
        weight = int(line[1][1:-1])
        children = []
        if len(line) > 2:
            children = list(map(lambda x: x.replace(',', ''), line[3:]))
        programs[name] = (weight, children)

calculate_weights(root)
find_fault(root, '')