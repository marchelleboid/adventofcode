namespace AdventOfCode2024.Day6;

public class Day6B : ISolver
{
    enum Direction
    {
        Up,
        Down,
        Right,
        Left
    }
    
    public void Solve()
    {
        var lines = File.ReadAllLines("Inputs\\day6.txt");

        var startX = 0;
        var startY = 0;
        
        
        var direction = Direction.Up;

        var foundIt = false;
        for (var y = 0; y < lines.Length; y++)
        {
            for (var x = 0; x < lines[0].Length; x++)
            {
                if (lines[y][x] == '^')
                {
                    startX = x;
                    startY = y;
                    foundIt = true;
                    break;
                }
            }

            if (foundIt)
            {
                break;
            }
        }
        
        var currentX = startX;
        var currentY = startY;

        var visited = new HashSet<(int, int)> { (currentX, currentY) };

        while (true)
        {
            var nextPosition = direction switch
            {
                Direction.Up => (currentX, currentY - 1),
                Direction.Down => (currentX, currentY + 1),
                Direction.Right => (currentX + 1, currentY),
                Direction.Left => (currentX - 1, currentY),
                _ => throw new ArgumentOutOfRangeException()
            };
            if (nextPosition.Item1 < 0 || nextPosition.Item1 >= lines[0].Length || 
                nextPosition.Item2 < 0 || nextPosition.Item2 >= lines.Length)
            {
                break;
            }
            if (lines[nextPosition.Item2][nextPosition.Item1] == '#')
            {
                direction = direction switch
                {
                    Direction.Up => Direction.Right,
                    Direction.Down => Direction.Left,
                    Direction.Right => Direction.Down,
                    Direction.Left => Direction.Up,
                    _ => throw new ArgumentOutOfRangeException()
                };
            }
            else
            {
                visited.Add(nextPosition);
                (currentX, currentY) = nextPosition;
            }
        }
        
        var count = 0;
        foreach (var position in visited)
        {
            currentX = startX;
            currentY = startY;
            direction = Direction.Up;
            var cycleVisited = new HashSet<(int, int, Direction)> { (currentX, currentY, Direction.Up) };
            var cycle = false;
            lines[position.Item2] = lines[position.Item2].Remove(position.Item1, 1).Insert(position.Item1, "#");
            while (true)
            {
                var nextPosition = direction switch
                {
                    Direction.Up => (currentX, currentY - 1, direction),
                    Direction.Down => (currentX, currentY + 1, direction),
                    Direction.Right => (currentX + 1, currentY, direction),
                    Direction.Left => (currentX - 1, currentY, direction),
                    _ => throw new ArgumentOutOfRangeException()
                };
                if (cycleVisited.Contains(nextPosition))
                {
                    cycle = true;
                    break;
                }
                if (nextPosition.Item1 < 0 || nextPosition.Item1 >= lines[0].Length || 
                    nextPosition.Item2 < 0 || nextPosition.Item2 >= lines.Length)
                {
                    break;
                }
                if (lines[nextPosition.Item2][nextPosition.Item1] == '#')
                {
                    direction = direction switch
                    {
                        Direction.Up => Direction.Right,
                        Direction.Down => Direction.Left,
                        Direction.Right => Direction.Down,
                        Direction.Left => Direction.Up,
                        _ => throw new ArgumentOutOfRangeException()
                    };
                }
                else
                {
                    cycleVisited.Add(nextPosition);
                    (currentX, currentY, direction) = nextPosition;
                }
            }

            if (cycle)
            {
                count++;
            }
            lines[position.Item2] = lines[position.Item2].Remove(position.Item1, 1).Insert(position.Item1, ".");
        }
        
        Console.WriteLine(count);
    }
}