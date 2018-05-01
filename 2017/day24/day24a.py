components = []
strongest = 0

with open('input') as f:
    for line in f:
        (a, b) = map(int, line.strip().split('/'))
        components.append((a, b))


def build_bridges(port_needed, existing_strength, components_left):
    components_possible = filter(lambda x: x[0] == port_needed or x[1] == port_needed, components_left)
    for component in components_possible:
        components_left_copy = list(components_left)
        components_left_copy.remove(component)
        new_strength = existing_strength + component[0] + component[1]
        global strongest
        if new_strength > strongest:
            strongest = new_strength
        next_port_needed = component[0] if component[1] == port_needed else component[1]
        build_bridges(next_port_needed, new_strength, components_left_copy)


build_bridges(0, 0, components)

print(strongest)