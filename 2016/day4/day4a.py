from collections import Counter

def is_valid_room(characters, checksum):
    count_map = {}
    for c in characters:
        if c in count_map:
            count_map[c] = count_map[c] + 1
        else:
            count_map[c] = 1
    sort_list = [v[0] for v in sorted(count_map.items(), key=lambda kv: (-kv[1], kv[0]))]
    real_checksum = ''.join(sort_list[0:5])
    return real_checksum == checksum

sector_id_sum = 0

with open('input') as f:
    for line in f:
        parts = line.strip().split('[')
        checksum = parts[1][:-1]
        name_parts = parts[0].split('-')
        sector_id = int(name_parts[-1])
        characters = "".join(name_parts[:-1])
        if is_valid_room(characters, checksum):
            sector_id_sum += sector_id

print(sector_id_sum)
