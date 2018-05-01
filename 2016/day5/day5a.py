import hashlib

input = 'abbhdwsy'

counter = 0

password = []

while len(password) < 8:
    trial = input + str(counter)
    m = hashlib.md5()
    m.update(trial.encode('utf-8'))
    hash = m.hexdigest()
    if hash.startswith('00000'):
        password.append(hash[5])
    counter += 1

print(''.join(password))