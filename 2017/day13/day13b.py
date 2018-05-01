layers = {}


class Layer:
    def __init__(self, depth):
        self.depth = depth
        self.scanner = 0
        self.down = True

    def move(self):
        if self.down:
            if self.scanner == self.depth - 1:
                self.down = False
                self.scanner -= 1
            else:
                self.scanner += 1
        else:
            if self.scanner == 0:
                self.down = True
                self.scanner += 1
            else:
                self.scanner -= 1

    def reset(self):
        self.scanner = 0
        self.down = True

    def fast_forward(self, turns):
        for i in range(turns):
            self.move()

    def will_be_caught(self, time):
        return time % (2 * (self.depth - 1)) == 0


with open('input') as f:
    for line in f:
        split_line = line.strip().split(': ')
        layer = int(split_line[0])
        depth = int(split_line[1])
        layers[layer] = Layer(depth)

max_layer = max(layers.keys())

current_layer = 0
delay = 0

while True:
    caught = False
    for i in range(max_layer + 1):
        if i in layers:
            if layers[i].will_be_caught(i + delay):
                caught = True
                break

    if not caught:
        break

    delay += 1

print(delay)
