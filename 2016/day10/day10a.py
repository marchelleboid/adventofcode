class Instruction:
    def __init__(self, output, number):
        self.output = output
        self.number = number

    def __repr__(self):
        return str(self.__dict__)

class Bot:
    def __init__(self, low_instruction, high_instruction):
        self.value1 = -1
        self.value2 = -1
        self.low_instruction = low_instruction
        self.high_instruction = high_instruction

    def add_value(self, value):
        if self.value1 == -1:
            self.value1 = value
        elif self.value2 == -1:
            self.value2 = value
        else:
            print("AHHHHHHH!")

    def has_two(self):
        return self.value1 != -1 and self.value2 != -1

    def get_low(self):
        return min(self.value1, self.value2), self.low_instruction

    def get_high(self):
        return max(self.value1, self.value2), self.high_instruction

    def is_winner(self):
        return (self.value1 == 61 and self.value2 == 17) or (self.value1 == 17 and self.value2 == 61)

    def reset(self):
        self.value1 = -1
        self.value2 = -1

    def __repr__(self):
        return str(self.__dict__)

bots = {}
outputs = {}

with open('input') as f:
    for line in f:
        line = line.strip()
        if line.startswith('bot'):
            bot = int(line.split(' ')[1])
            low_number = int(line.split(' ')[6])
            low_output = line.split(' ')[5] == 'output'
            high_number = int(line.split(' ')[-1])
            high_output = line.split(' ')[-2] == 'output'
            low_instruction = Instruction(low_output, low_number)
            high_instruction = Instruction(high_output, high_number)
            bots[bot] = Bot(low_instruction, high_instruction)

with open('input') as f:
    for line in f:
        line = line.strip()
        if line.startswith("value"):
            value = int(line.split(' ')[1])
            bot = int(line.split(' ')[-1])
            bots[bot].add_value(value)

while True:
    ready_bots = []
    for k, v in bots.items():
        if v.has_two():
            ready_bots.append(k)
    for ready_bot in ready_bots:
        bot = bots[ready_bot]
        if bot.is_winner():
            print(ready_bot)
            exit()
        low_value, low_instruction = bot.get_low()
        if low_instruction.output:
            outputs[low_instruction.number] = low_value
        else:
            bots[low_instruction.number].add_value(low_value)
        high_value, high_instruction = bot.get_high()
        if high_instruction.output:
            outputs[high_instruction.number] = high_value
        else:
            bots[high_instruction.number].add_value(high_value)
        bot.reset()