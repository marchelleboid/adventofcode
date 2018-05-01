from copy import deepcopy

replacements = {}

with open('input') as f:
    lines = f.readlines()
    for line in lines:
        line = line.strip()
        if line == "":
            break
        (molecule, stupid, replacement) = line.split(" ")
        if molecule not in replacements:
            replacements[molecule] = []
        replacements[molecule] += [replacement]

    molecule = lines[-1]

tokenized_molecule = []

current_token = ""
for c in molecule:
    if c.isupper():
        if current_token != "":
            tokenized_molecule += [current_token]
        current_token = c
    else:
        current_token += c
tokenized_molecule += [current_token]

new_molecules = set()

for x in range(0, len(tokenized_molecule)):
    if tokenized_molecule[x] in replacements:
        for replacement in replacements[tokenized_molecule[x]]:
            tokenized_molecule_copy = deepcopy(tokenized_molecule)
            tokenized_molecule_copy[x] = replacement
            new_molecules.add("".join(tokenized_molecule_copy))

print(len(new_molecules))
