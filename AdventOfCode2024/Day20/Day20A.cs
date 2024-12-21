namespace AdventOfCode2024.Day20;

public class Day20A : ISolver
{
    public void Solve()
    {
        var lines = File.ReadAllLines("Inputs\\day20.txt");

        var start = (x: 0, y: 0);
        var end = (x: 0, y: 0);

        for (var y = 0; y < lines.Length; y++)
        {
            for (var x = 0; x < lines[0].Length; x++)
            {
                switch (lines[y][x])
                {
                    case 'S':
                        start = (x, y);
                        break;
                    case 'E':
                        end = (x, y);
                        break;
                }
            }
        }
        
        var bestPath = new List<(int, int)> { start };
        var current = start;
        var last = start;
        while (true)
        {
            var (x, y) = current;
            if (current == end)
            {
                break;
            }
            
            if (last != (x, y - 1) && lines[y - 1][x] != '#')
            {
                bestPath.Add((x, y - 1));
                last = current;
                current = (x, y - 1);
            } 
            else if (last != (x, y + 1) && lines[y + 1][x] != '#')
            {
                bestPath.Add((x, y + 1));
                last = current;
                current = (x, y + 1);
            } 
            else if (last != (x - 1, y) && lines[y][x - 1] != '#')
            {
                bestPath.Add((x - 1, y));
                last = current;
                current = (x - 1, y);
            } 
            else if (last != (x + 1, y) && lines[y][x + 1] != '#')
            {
                bestPath.Add((x + 1, y));
                last = current;
                current = (x + 1, y);
            }
        }
        
        var bestPathMap = new Dictionary<(int x, int y), int>();
        for (var i = 0; i < bestPath.Count; i++)
        {
            bestPathMap[bestPath[i]] = i;
        }

        var count = 0;
        const int goalToSave = 100;
        for (var i = 0; i < bestPath.Count; i++)
        {
            var (x, y) = bestPath[i];
            if (y - 1 != 0 && lines[y - 1][x] == '#' && lines[y - 2][x] != '#')
            {
                if (bestPathMap[(x, y - 2)] >= i + 2 + goalToSave)
                {
                    count++;
                }
            }
            
            if (y + 1 != lines.Length - 1 && lines[y + 1][x] == '#' && lines[y + 2][x] != '#')
            {
                if (bestPathMap[(x, y + 2)] >= i + 2 + goalToSave)
                {
                    count++;
                }
            }
            
            if (x - 1 != 0 && lines[y][x - 1] == '#' && lines[y][x - 2] != '#')
            {
                if (bestPathMap[(x - 2, y)] >= i + 2 + goalToSave)
                {
                    count++;
                }
            }
            
            if (x + 1 != lines[0].Length - 1 && lines[y][x + 1] == '#' && lines[y][x + 2] != '#')
            {
                if (bestPathMap[(x + 2, y)] >= i + 2 + goalToSave)
                {
                    count++;
                }
            }
        }
        Console.WriteLine(count);
    }
}