namespace AdventOfCode2024.Day6;

public class Day6A : ISolver
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

        var currentX = 0;
        var currentY = 0;
        
        var direction = Direction.Up;

        var foundIt = false;
        for (var y = 0; y < lines.Length; y++)
        {
            for (var x = 0; x < lines[0].Length; x++)
            {
                if (lines[y][x] == '^')
                {
                    currentX = x;
                    currentY = y;
                    foundIt = true;
                    break;
                }
            }

            if (foundIt)
            {
                break;
            }
        }

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
        Console.WriteLine(visited.Count);
    }
}