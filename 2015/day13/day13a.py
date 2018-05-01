graph = {}

with open('input') as f:
    for line in f:
        line = line.strip()
        line = line[:-1]
        split_line = line.split(" ")
        person_a = split_line[0]
        amount = int(split_line[3])
        if split_line[2] == "lose":
            amount *= -1
        person_b = split_line[-1]

        if person_a not in graph:
            graph[person_a] = {}
        graph[person_a][person_b] = amount

biggest_happiness = 0

people = graph.keys()

def calculate_happinesses(happiness, people_chosen):
    global biggest_happiness
    if len(people_chosen) == len(people):
        happiness += graph[people_chosen[-1]][people_chosen[0]]
        happiness += graph[people_chosen[0]][people_chosen[-1]]
        if happiness > biggest_happiness:
            biggest_happiness = happiness
    else:
        next_peoples = graph[people_chosen[-1]]
        for key in next_peoples:
            if key not in people_chosen:
                calculate_happinesses(happiness + graph[key][people_chosen[-1]] + graph[people_chosen[-1]][key], people_chosen + [key])

calculate_happinesses(0, [list(graph.keys())[0]])

print(biggest_happiness)
