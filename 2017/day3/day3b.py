target = 312051

def addNeighboringSquares(board, x, y):
    return board[x + 1][y] + board[x + 1][y + 1] + board[x][y + 1] + board[x - 1][y + 1] + board[x - 1][y] \
        + board[x - 1][y - 1] + board[x][y - 1] + board[x + 1][y - 1]

size = 50
Matrix = [[0 for x in range(size)] for y in range(size)]

locationX = 25
locationY = 25
Matrix[25][25] = 1
direction = 'right'

while True:
    if direction == 'right':
        locationX += 1
        if Matrix[locationX][locationY + 1] == 0:
            direction = 'up'
    elif direction == 'up':
        locationY += 1
        if Matrix[locationX - 1][locationY] == 0:
            direction = 'left'
    elif direction == 'left':
        locationX -= 1
        if Matrix[locationX][locationY - 1] == 0:
            direction = 'down'
    elif direction == 'down':
        locationY -= 1
        if Matrix[locationX + 1][locationY] == 0:
            direction = 'right'
    nextValue = addNeighboringSquares(Matrix, locationX, locationY)
    Matrix[locationX][locationY] = nextValue
    if nextValue > target:
        print(nextValue)
        break
