class Particle:
    def __init__(self, counter, p_x, p_y, p_z, v_x, v_y, v_z, a_x, a_y, a_z):
        self.counter = counter
        self.p_x = p_x
        self.p_y = p_y
        self.p_z = p_z
        self.v_x = v_x
        self.v_y = v_y
        self.v_z = v_z
        self.a_x = a_x
        self.a_y = a_y
        self.a_z = a_z

    def tick(self):
        self.v_x += self.a_x
        self.v_y += self.a_y
        self.v_z += self.a_z
        self.p_x += self.v_x
        self.p_y += self.v_y
        self.p_z += self.v_z

    def distance_from_center(self):
        return abs(self.p_x) + abs(self.p_y) + abs(self.p_z)


particles = []


with open('input') as f:
    counter = 0
    for line in f:
        split_line = line.strip().split(', ')
        position = split_line[0]
        velocity = split_line[1]
        acceleration = split_line[2]
        (p_x, p_y, p_z) = map(int, position[3:-1].split(','))
        (v_x, v_y, v_z) = map(int, velocity[3:-1].split(','))
        (a_x, a_y, a_z) = map(int, acceleration[3:-1].split(','))
        particles.append(Particle(counter, p_x, p_y, p_z, v_x, v_y, v_z, a_x, a_y, a_z))
        counter += 1

for i in range(10000):
    for particle in particles:
        particle.tick()

closest = min(particles, key=lambda x: x.distance_from_center())
print(closest.counter)