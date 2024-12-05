namespace AdventOfCode2024.Day5;

public class Day5A : ISolver
{
    public void Solve()
    {
        var orderingRules = new Dictionary<int, List<int>>();
        var count = 0;
        
        var lines = File.ReadLines("Inputs\\day5.txt");
        
        foreach (var line in lines)
        {
            if (line.Length == 0)
            {
                continue;
            }

            if (line.Contains('|'))
            {
                var split = line.Split('|').Select(int.Parse).ToList();
                var rules = orderingRules.GetValueOrDefault(split[0], []);
                rules.Add(split[1]);
                orderingRules[split[0]] = rules;
            }
            else
            {
                var split = line.Split(',').Select(int.Parse).ToList();
                var good = true;
                while (split.Count > 0 && good)
                {
                    var current = split[0];
                    split.RemoveAt(0);
                    if (split.Any(rest => orderingRules.GetValueOrDefault(rest, []).Contains(current)))
                    {
                        good = false;
                    }
                }

                if (good)
                {
                    split = line.Split(',').Select(int.Parse).ToList();
                    count += split[split.Count / 2];
                }
            }
        }
        
        Console.WriteLine(count);
    }
}