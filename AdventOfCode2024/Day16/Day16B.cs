namespace AdventOfCode2024.Day16;

public class Day16B : ISolver
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
        var lines = File.ReadAllLines("Inputs\\day16.txt");

        var end = (0, 0);
        var reindeerX = 0;
        var reindeerY = 0;
        for (var y = 0; y < lines.Length; y++)
        {
            for (var x = 0; x < lines[0].Length; x++)
            {
                switch (lines[y][x])
                {
                    case 'E':
                        end = (x, y);
                        break;
                    case 'S':
                        reindeerX = x;
                        reindeerY = y;
                        break;
                }
            }
        }
        
        var seen = new Dictionary<(int x, int y , Direction direction), int> { { (reindeerX, reindeerY, Direction.Right), 0 } };

        var queue = new PriorityQueue<(int x, int y , Direction direction, int score, List<(int, int)> spots), int>();
        queue.Enqueue((reindeerX, reindeerY, Direction.Right, 0, [(reindeerX, reindeerY)]), 0);
        var bestPathScore = int.MaxValue;
        var bestPathSpots = new HashSet<(int x, int y)>();
        while (queue.Count > 0)
        {
            var (x, y, direction, score, spots) = queue.Dequeue();
            if (score > bestPathScore)
            {
                continue;
            }
            
            if ((x, y) == end)
            {
                bestPathScore = score;
                bestPathSpots.UnionWith(spots);
            }

            (int, int) straight;
            (int, int) left;
            (int, int) right;
            Direction newLeftDirection;
            Direction newRightDirection;
            
            switch (direction)
            {
                case Direction.Up:
                    straight = (x, y - 1);
                    left = (x - 1, y);
                    newLeftDirection = Direction.Left;
                    right = (x + 1, y);
                    newRightDirection = Direction.Right;
                    break;
                case Direction.Down:
                    straight = (x, y + 1);
                    left = (x + 1, y);
                    newLeftDirection = Direction.Right;
                    right = (x - 1, y);
                    newRightDirection = Direction.Left;
                    break;
                case Direction.Right:
                    straight = (x + 1, y);
                    left = (x, y - 1);
                    newLeftDirection = Direction.Up;
                    right = (x, y + 1);
                    newRightDirection = Direction.Down;
                    break;
                case Direction.Left:
                    straight = (x - 1, y);
                    left = (x, y + 1);
                    newLeftDirection = Direction.Down;
                    right = (x, y - 1);
                    newRightDirection = Direction.Up;
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }

            if (lines[straight.Item2][straight.Item1] != '#' &&
                seen.GetValueOrDefault((straight.Item1, straight.Item2, direction), int.MaxValue) >= score + 1)
            {
                seen[(straight.Item1, straight.Item2, direction)] = score + 1;
                var newSpots = new List<(int, int)>(spots) { (straight.Item1, straight.Item2) };
                queue.Enqueue((straight.Item1, straight.Item2, direction, score + 1, newSpots), score + 1);
            }
            
            if (lines[left.Item2][left.Item1] != '#' &&
                seen.GetValueOrDefault((x, y, newLeftDirection), int.MaxValue) >= score + 1000)
            {
                seen[(x, y, newLeftDirection)] = score + 1000;
                var newSpots = new List<(int, int)>(spots);
                queue.Enqueue((x, y, newLeftDirection, score + 1000, newSpots), score + 1000);
            }
            
            if (lines[right.Item2][right.Item1] != '#' &&
                seen.GetValueOrDefault((x, y, newRightDirection), int.MaxValue) >= score + 1000)
            {
                seen[(x, y, newRightDirection)] = score + 1000;
                var newSpots = new List<(int, int)>(spots);
                queue.Enqueue((x, y, newRightDirection, score + 1000, newSpots), score + 1000);
            }
        }
        Console.WriteLine(bestPathSpots.Count);
    }
}