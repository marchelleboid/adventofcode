input = "vzbxkghb"

def increment_password(password):
    password_bytes = bytearray(password, "utf-8")
    for x in range(0, len(password)):
        position = len(password) - 1 - x
        if password[position] == "z":
            password_bytes[position] = ord("a")
        else:
            password_bytes[position] = ord(password[position]) + 1
            return password_bytes.decode("utf-8")

def contains_iol(password):
    return "i" in password or "o" in password or "l" in password

def no_straight(password):
    c = 0
    while c < len(password) - 2:
        c0 = password[c]
        c1 = password[c + 1]
        c2 = password[c + 2]
        if ord(c0) + 1 == ord(c1) and ord(c0) + 2 == ord(c2):
            return False
        else:
            c += 1

    return True

def no_doubles(password):
    count = 0
    c = 0
    while c < len(password) - 1:
        if password[c] == password[c + 1]:
            if count == 1:
                return False
            count = 1
            c += 2
        else:
            c += 1

    return True

input = increment_password(input)

while True:
    if contains_iol(input) or no_straight(input) or no_doubles(input):
        input = increment_password(input)
    else:
        break

print(input)
