namespace AdventOfCode2024.Day20;

public class Day20B : ISolver
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
            for (var dx = 0; dx <= 20; dx++)
            {
                for (var dy = 20 - dx; dy >= 0; dy--)
                {
                    if (dx == 0 && dy == 0)
                    {
                        continue;
                    }

                    var picosecondsJump = i + dx + dy;
                    var spotsToTest = new HashSet<(int x, int y)>
                    {
                        (x + dx, y + dy),
                        (x + dx, y - dy),
                        (x - dx, y + dy),
                        (x - dx, y - dy)
                    };

                    count += spotsToTest.Where(spotToTest => IsOnRacePath(spotToTest.x, spotToTest.y, lines))
                        .Count(spotToTest => bestPathMap[(spotToTest.x, spotToTest.y)] >= picosecondsJump + goalToSave);
                }
            }
        }
        Console.WriteLine(count);
    }

    private static bool IsOnRacePath(int x, int y, string[] lines)
    {
        if (x < 0 || x >= lines[0].Length)
        {
            return false;
        }
        
        if (y < 0 || y >= lines.Length)
        {
            return false;
        }

        return lines[y][x] != '#';
    }
}