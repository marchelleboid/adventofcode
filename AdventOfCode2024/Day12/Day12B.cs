namespace AdventOfCode2024.Day12;

public class Day12B : ISolver
{
    private readonly HashSet<(int, int)> _visited = [];
    
    public void Solve()
    {
        var lines = File.ReadAllLines("Inputs\\day12.txt");

        var price = 0;
        for (var y = 0; y < lines.Length; y++)
        {
            for (var x = 0; x < lines[0].Length; x++)
            {
                if (_visited.Contains((x, y)))
                {
                    continue;
                }

                price += CountRegion(lines, x, y);
            }
        }
        
        Console.WriteLine(price);
    }

    private int CountRegion(string[] lines, int x, int y)
    {
        var area = 0;
        var vertices = 0;
        var label = lines[y][x];
        
        var queue = new Queue<(int, int)>();
        queue.Enqueue((x, y));
        _visited.Add((x, y));

        while (queue.Count > 0)
        {
            var (x2, y2) = queue.Dequeue();
            area++;

            var leftGood = (x2 > 0 && lines[y2][x2 - 1] == label);
            var rightGood = (x2 < lines[0].Length - 1 && lines[y2][x2 + 1] == label);
            var topGood = (y2 > 0 && lines[y2 - 1][x2] == label);
            var bottomGood = (y2 < lines.Length - 1 && lines[y2 + 1][x2] == label);

            if (!leftGood && !topGood)
            {
                vertices++;
            }
            if (!rightGood && !topGood)
            {
                vertices++;
            }
            if (!leftGood && !bottomGood)
            {
                vertices++;
            }
            if (!rightGood && !bottomGood)
            {
                vertices++;
            }

            if (leftGood && topGood)
            {
                if (lines[y2 - 1][x2 - 1] != label)
                {
                    vertices++;
                }
            }
            if (rightGood && topGood)
            {
                if (lines[y2 - 1][x2 + 1] != label)
                {
                    vertices++;
                }
            }
            if (leftGood && bottomGood)
            {
                if (lines[y2 + 1][x2 - 1] != label)
                {
                    vertices++;
                }
            }
            if (rightGood && bottomGood)
            {
                if (lines[y2 + 1][x2 + 1] != label)
                {
                    vertices++;
                }
            }
            
            if (leftGood)
            {
                if (!_visited.Contains((x2 - 1, y2)))
                {
                    queue.Enqueue((x2 - 1, y2));
                    _visited.Add((x2 - 1, y2));
                }
            }
            
            if (rightGood)
            {
                if (!_visited.Contains((x2 + 1, y2)))
                {
                    queue.Enqueue((x2 + 1, y2));
                    _visited.Add((x2 + 1, y2));
                }
            }
            
            if (topGood)
            {
                if (!_visited.Contains((x2, y2 - 1)))
                {
                    queue.Enqueue((x2, y2 - 1));
                    _visited.Add((x2, y2 - 1));
                }
            }
            
            if (bottomGood)
            {
                if (!_visited.Contains((x2, y2 + 1)))
                {
                    queue.Enqueue((x2, y2 + 1));
                    _visited.Add((x2, y2 + 1));
                }
            }
        }
        
        return area * vertices;
    }
}