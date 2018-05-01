clues = {"children": 3, "cats": 7, "samoyeds": 2, "pomeranians": 3, "akitas": 0, "vizslas": 0, "goldfish": 5, "trees": 3, "cars": 2, "perfumes": 1}

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
        if clues[item_1] == item_1_value and clues[item_2] == item_2_value and clues[item_3] == item_3_value:
            print(sue_number)
