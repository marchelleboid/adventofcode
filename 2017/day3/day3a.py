location = 312051

side_length = 1
while True:
    next_square = side_length * side_length
    if next_square >= location:
        break
    side_length += 2

special_case = True
nearest_corner = next_square
while nearest_corner > ((side_length - 2) * (side_length - 2)):
    lower_bound = nearest_corner - (side_length - 1)/2
    upper_bound = nearest_corner + (side_length - 1)/2
    if lower_bound <= location < upper_bound:
        break
    nearest_corner = nearest_corner - (side_length - 1)

distance_to_center = (side_length - 1) - abs(nearest_corner - location)
print(distance_to_center)