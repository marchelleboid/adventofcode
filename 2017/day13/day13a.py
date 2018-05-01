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


with open('input') as f:
    for line in f:
        split_line = line.strip().split(': ')
        layer = int(split_line[0])
        depth = int(split_line[1])
        layers[layer] = Layer(depth)

current_layer = 0
severity = 0

max_layer = max(layers.keys())

for i in range(max_layer + 1):
    if i in layers:
        if layers[i].scanner == 0:
            layer_severity = i * layers[i].depth
            severity += layer_severity

    for key, value in layers.items():
        value.move()

print(severity)
