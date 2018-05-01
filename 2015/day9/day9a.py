import sys

graph = {}

with open('input') as f:
    for line in f:
        line = line.strip()
        (start, blah, end, blah2, distance) = line.split(" ")
        distance = int(distance)
        if start not in graph:
            graph[start] = {}
        if end not in graph:
            graph[end] = {}
        graph[start][end] = distance
        graph[end][start] = distance

shortest_distance = sys.maxsize

def calculate_distance(distance, cities_visited):
    global shortest_distance 
    if len(cities_visited) == len(cities):
        if distance < shortest_distance:
            shortest_distance = distance
    else:
        distances = graph[cities_visited[-1]]
        for key in distances:
            if key not in cities_visited:
                calculate_distance(distance + distances[key], cities_visited + [key])

cities = graph.keys()
for city in cities:
    calculate_distance(0, [city])

print(shortest_distance)