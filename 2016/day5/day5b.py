import hashlib

input = 'abbhdwsy'

counter = 0

password = ['-', '-', '-', '-', '-', '-', '-', '-']

while '-' in password:
    trial = input + str(counter)
    m = hashlib.md5()
    m.update(trial.encode('utf-8'))
    hash = m.hexdigest()
    if hash.startswith('00000'):
        position = hash[5]
        value = hash[6]
        if position.isdigit() and int(position) < 8 and password[int(position)] == '-':
            password[int(position)] = value
    counter += 1

print(''.join(password))