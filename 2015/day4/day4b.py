import hashlib

inputS = "bgvyzdsv"

counter = 1

while True:
    inputAndCounter = inputS + str(counter)

    m = hashlib.md5()
    m.update(inputAndCounter.encode())
    digest = m.hexdigest()

    if (digest[0:6] == "000000"):
        print(counter)
        break

    counter += 1
