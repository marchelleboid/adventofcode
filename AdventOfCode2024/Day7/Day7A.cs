namespace AdventOfCode2024.Day7;

public class Day7A : ISolver
{
    public void Solve()
    {
        var count = 0L;
        
        var lines = File.ReadLines("Inputs\\day7.txt");
        foreach (var line in lines)
        {
            var split = line.Split(": ");
            var goal = long.Parse(split[0]);
            var operators = split[1].Trim().Split(" ").Select(long.Parse).ToList();
            
            var queue = new Queue<List<long>>();
            queue.Enqueue(operators);
            
            while (queue.Count > 0)
            {
                var current = queue.Dequeue();
                if (current.Count == 1)
                {
                    if (current.First() == goal)
                    {
                        count += goal;
                        break;
                    }

                    continue;
                }

                var first = current.First();
                current.RemoveAt(0);
                var second = current.First();
                current.RemoveAt(0);

                var addition = first + second;
                var multiplication = first * second;

                if (addition <= goal)
                {
                    queue.Enqueue(new List<long> { addition }.Concat(current).ToList());
                }

                if (multiplication <= goal)
                {
                    queue.Enqueue(new List<long> { multiplication }.Concat(current).ToList());
                }
            }
        }
        Console.WriteLine(count);
    }
}