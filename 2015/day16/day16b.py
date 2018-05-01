clues = {"children": 3, "cats": 7, "samoyeds": 2, "pomeranians": 3, "akitas": 0, "vizslas": 0, "goldfish": 5, "trees": 3, "cars": 2, "perfumes": 1}

def is_item_correct(item, item_value):
    if item == "cats" or item == "trees":
        return clues[item] < item_value
    elif item == "pomeranians" or item == "goldfish":
        return clues[item] > item_value
    else:
        return clues[item] == item_value

with open('input') as f:
    for line in f:
        line = line.strip()
        line = line.replace(",", "")
        line = line.replace(":", "")
        split_line = line.split(" ")
        sue_number = split_line[1]
        item_1 = split_line[2]
        item_1_value = int(split_line[3])
        item_2 = split_line[4]
        item_2_value = int(split_line[5])
        item_3 = split_line[6]
        item_3_value = int(split_line[7])
        item_1_correct = is_item_correct(item_1, item_1_value)
        item_2_correct = is_item_correct(item_2, item_2_value)
        item_3_correct = is_item_correct(item_3, item_3_value)
        if item_1_correct and item_2_correct and item_3_correct:
            print(sue_number)