programs = {}

with open('input') as f:
    for line in f:
        line = line.strip().split(' ')
        name = line[0]
        weight = int(line[1][1:-1])
        children = []
        if len(line) > 2:
            children = list(map(lambda x: x.replace(',', ''), line[3:]))
        programs[name] = (weight, children)

programs_with_children = {k: v for k, v in programs.items() if v[1]}

names_with_children = programs_with_children.keys()
children_programs = [item for sublist in [v[1] for k, v in programs_with_children.items()] for item in sublist]
print(list(set(names_with_children).difference(children_programs))[0])