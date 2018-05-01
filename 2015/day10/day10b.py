input = "1113222113"

for x in range(0, 50):
    new_input = ""
    current_character = ""
    count = 0
    for c in range(0, len(input)):
        if count == 0:
            current_character = input[c]
            count = 1
        elif input[c] == current_character:
            count += 1
        else:
            new_input += str(count)
            new_input += current_character
            count = 1
            current_character = input[c]
    new_input += str(count)
    new_input += current_character
    input = new_input

print(len(input))
    