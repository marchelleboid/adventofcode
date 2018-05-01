import itertools

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


def shift_character(character):
    if character == '-':
        return ' '
    elif character == ' ':
        return '-'
    elif character == 'z':
        return 'a'
    else:
        return chr(ord(character) + 1)

def decrypt_name(name, sector_id):
    name_copy = name
    for _ in itertools.repeat(None, sector_id):
        name_copy = ''.join(list(map(shift_character, name_copy)))
    return name_copy

with open('input') as f:
    for line in f:
        parts = line.strip().split('[')
        checksum = parts[1][:-1]
        name = parts[0][0:parts[0].rfind('-')]
        name_parts = parts[0].split('-')
        sector_id = int(name_parts[-1])
        characters = "".join(name_parts[:-1])
        if is_valid_room(characters, checksum):
            decrypted_name = decrypt_name(name, sector_id)
            if decrypted_name.startswith('north'):
                print(decrypt_name(name, sector_id) + ' ' + str(sector_id))
