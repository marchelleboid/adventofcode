namespace AdventOfCode2024.Day18;

public class Day18B : ISolver
{
    public void Solve()
    {
        var lines = File.ReadAllLines("Inputs\\day18.txt");

        var corrupted = new HashSet<(int x, int y)>();

        const int limit = 1024;
        foreach (var line in lines)
        {
            var split = line.Split(",");
            corrupted.Add((int.Parse(split[0]), int.Parse(split[1])));
            if (corrupted.Count == limit)
            {
                break;
            }
        }

        const int end = 70;
        var goodUntil = 1024;

        for (var i = 1025; i < lines.Length; i++)
        {
            var split = lines[i].Split(",");
            corrupted.Add((int.Parse(split[0]), int.Parse(split[1])));
            
            var seen = new Dictionary<(int x, int y), int> { { (0, 0), 0 } };

            var madeIt = false;
            var queue = new PriorityQueue<(int x, int y, int steps), int>();
            queue.Enqueue((0, 0, 0), 0);
            while (queue.Count > 0)
            {
                var (x, y, steps) = queue.Dequeue();
                if (x == end && y == end)
                {
                    madeIt = true;
                    break;
                }
    
                var newSteps = steps + 1;
    
                if (x > 0 && !corrupted.Contains((x - 1, y)))
                {
                    if (seen.GetValueOrDefault((x - 1, y), int.MaxValue) > newSteps)
                    {
                        seen[(x - 1, y)] = newSteps;
                        queue.Enqueue((x - 1, y, newSteps), newSteps);
                    }
                }
                
                if (y > 0 && !corrupted.Contains((x, y - 1)))
                {
                    if (seen.GetValueOrDefault((x, y - 1), int.MaxValue) > newSteps)
                    {
                        seen[(x, y - 1)] = newSteps;
                        queue.Enqueue((x, y - 1, newSteps), newSteps);
                    }
                }
                
                if (x < end && !corrupted.Contains((x + 1, y)))
                {
                    if (seen.GetValueOrDefault((x + 1, y), int.MaxValue) > newSteps)
                    {
                        seen[(x + 1, y)] = newSteps;
                        queue.Enqueue((x + 1, y, newSteps), newSteps);
                    }
                }
                
                if (y < end && !corrupted.Contains((x, y + 1)))
                {
                    if (seen.GetValueOrDefault((x, y + 1), int.MaxValue) > newSteps)
                    {
                        seen[(x, y + 1)] = newSteps;
                        queue.Enqueue((x, y + 1, newSteps), newSteps);
                    }
                }
            }

            if (madeIt)
            {
                goodUntil = i;
            }
            else
            {
                break;
            }
        }
        Console.WriteLine(lines[goodUntil + 1]);
    }
}