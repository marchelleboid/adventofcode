class Program:
    def __init__(self, p_value):
        self.registers = {'p': p_value}
        self.p_value = p_value
        self.pointer = 0
        self.queue = []
        self.sent_items = 0

    def receive_value(self, value):
        self.queue.append(value)

    def get_value(self, thing):
        try:
            return int(thing)
        except ValueError:
            if thing in self.registers:
                return self.registers[thing]
            else:
                return 0

    def run_next(self):
        if self.pointer < 0 or self.pointer > len(lines):
            return False

        split_line = lines[self.pointer].strip().split()
        command = split_line[0]
        arg1 = split_line[1]

        if command == 'snd':
            value = self.get_value(arg1)
            if self.p_value == 0:
                program_1.receive_value(value)
            else:
                program_0.receive_value(value)
            self.pointer += 1
            self.sent_items += 1
        elif command == 'set':
            arg2 = split_line[2]
            self.registers[arg1] = self.get_value(arg2)
            self.pointer += 1
        elif command == 'add':
            arg2 = split_line[2]
            if arg1 in self.registers:
                value = self.registers[arg1]
            else:
                value = 0
            self.registers[arg1] = value + self.get_value(arg2)
            self.pointer += 1
        elif command == 'mul':
            arg2 = split_line[2]
            if arg1 in self.registers:
                value = self.registers[arg1]
            else:
                value = 0
            self.registers[arg1] = value * self.get_value(arg2)
            self.pointer += 1
        elif command == 'mod':
            arg2 = split_line[2]
            if arg1 in self.registers:
                value = self.registers[arg1]
            else:
                value = 0
            self.registers[arg1] = value % self.get_value(arg2)
            self.pointer += 1
        elif command == 'rcv':
            if not len(self.queue):
                return False
            self.registers[arg1] = self.queue.pop(0)
            self.pointer += 1
        elif command == 'jgz':
            arg2 = split_line[2]
            value1 = self.get_value(arg1)
            value2 = self.get_value(arg2)
            if value1 > 0:
                self.pointer += value2
            else:
                self.pointer += 1

        return True


with open('input') as f:
    lines = f.readlines()

program_0 = Program(0)
program_1 = Program(1)

while True:
    failed_0 = False
    failed_1 = False

    if not program_0.run_next():
        failed_0 = True

    if not program_1.run_next():
        failed_1 = True

    if failed_0 and failed_1:
        break

print(program_1.sent_items)
