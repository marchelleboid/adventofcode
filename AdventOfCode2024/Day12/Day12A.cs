using System.Security.Cryptography;

namespace AdventOfCode2024.Day12;

public class Day12A : ISolver
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
        var perimeter = 0;
        var label = lines[y][x];
        
        var queue = new Queue<(int, int)>();
        queue.Enqueue((x, y));
        _visited.Add((x, y));

        while (queue.Count > 0)
        {
            var (x2, y2) = queue.Dequeue();
            area++;

            if (x2 > 0 && lines[y2][x2 - 1] == label)
            {
                if (!_visited.Contains((x2 - 1, y2)))
                {
                    queue.Enqueue((x2 - 1, y2));
                    _visited.Add((x2 - 1, y2));
                }
            }
            else
            {
                perimeter++;
            }
            
            if (x2 < lines[0].Length - 1 && lines[y2][x2 + 1] == label)
            {
                if (!_visited.Contains((x2 + 1, y2)))
                {
                    queue.Enqueue((x2 + 1, y2));
                    _visited.Add((x2 + 1, y2));
                }
            }
            else
            {
                perimeter++;
            }
            
            if (y2 > 0 && lines[y2 - 1][x2] == label)
            {
                if (!_visited.Contains((x2, y2 - 1)))
                {
                    queue.Enqueue((x2, y2 - 1));
                    _visited.Add((x2, y2 - 1));
                }
            }
            else
            {
                perimeter++;
            }
            
            if (y2 < lines.Length - 1 && lines[y2 + 1][x2] == label)
            {
                if (!_visited.Contains((x2, y2 + 1)))
                {
                    queue.Enqueue((x2, y2 + 1));
                    _visited.Add((x2, y2 + 1));
                }
            }
            else
            {
                perimeter++;
            }
        }
        
        return area * perimeter;
    }
}