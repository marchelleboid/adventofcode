import json

count = 0


def count_numbers(json_node):
        global count
        if isinstance(json_node, int):
            count += int(json_node)
            return
        elif isinstance(json_node, str):
            return
        elif isinstance(json_node, list):
            for node in list(json_node):
                count_numbers(node)
        elif isinstance(json_node, dict):
            for key in json_node:
                if json_node[key] == "red":
                    return
            for key in json_node:
                count_numbers(json_node[key])
        else:
            print("OH NO!")


with open('input') as f:
    json_stuff = json.load(f)
    count_numbers(json_stuff)

print(count)
