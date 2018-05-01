next_buttons = {'1': {'U': '1', 'R': '1', 'D': '3', 'L': '1'},
                '2': {'U': '2', 'R': '3', 'D': '6', 'L': '1'},
                '3': {'U': '1', 'R': '4', 'D': '7', 'L': '2'},
                '4': {'U': '4', 'R': '4', 'D': '8', 'L': '3'},
                '5': {'U': '5', 'R': '6', 'D': '5', 'L': '5'},
                '6': {'U': '2', 'R': '7', 'D': 'A', 'L': '5'},
                '7': {'U': '3', 'R': '8', 'D': 'B', 'L': '6'},
                '8': {'U': '4', 'R': '9', 'D': 'C', 'L': '7'},
                '9': {'U': '9', 'R': '9', 'D': '9', 'L': '8'},
                'A': {'U': '6', 'R': 'B', 'D': 'A', 'L': 'A'},
                'B': {'U': '7', 'R': 'C', 'D': 'D', 'L': 'A'},
                'C': {'U': '8', 'R': 'C', 'D': 'C', 'L': 'B'},
                'D': {'U': 'B', 'R': 'D', 'D': 'D', 'L': 'D'}}

button = '5'

code = []

with open('input') as f:
    for line in f:
        for direction in line:
            if direction != '\n':
                button = next_buttons[button][direction]
        code.append(button)

print(''.join(code))
