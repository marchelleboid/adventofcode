import hashlib

salt = 'yjdafjpo'
index = 0

waiting_keys = {}
final_index = -1
keys_found = []

while True:
    current_salt = salt + str(index)
    current_hash = hashlib.md5(current_salt.encode('utf-8')).hexdigest()

    for x in range(len(current_hash) - 2):
        if current_hash[x] == current_hash[x + 1] == current_hash[x + 2]:
            triplet = current_hash[x]
            waiting_keys[index] = triplet
            break

    for x in range(len(current_hash) - 4):
        if current_hash[x] == current_hash[x + 1] == current_hash[x + 2] == current_hash[x + 3] == current_hash[x + 4]:
            quintuplet = current_hash[x]
            keys = sorted(waiting_keys.keys())[:-1]
            for key in keys:
                if waiting_keys[key] == quintuplet:
                    keys_found.append(key)
                    waiting_keys.pop(key, None)
                    if len(keys_found) == 64:
                        final_index = index + 1000

    if index >= 1000:
        waiting_keys.pop(index - 1000, None)

    if final_index == index:
        break
    else:
        index += 1

print(sorted(keys_found)[63])
