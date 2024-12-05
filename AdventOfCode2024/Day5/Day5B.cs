namespace AdventOfCode2024.Day5;

public class Day5B : ISolver
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
                while (split.Count > 0)
                {
                    var current = split[0];
                    split.RemoveAt(0);
                    if (split.Any(rest => orderingRules.GetValueOrDefault(rest, []).Contains(current)))
                    {
                        good = false;
                    }
                }

                if (!good)
                {
                    var splitArray = line.Split(',').Select(int.Parse).ToArray();
                    var i = 0;
                    while (i <= splitArray.Length / 2)
                    {
                        bool swapped = false;
                        for (var j = i; j < splitArray.Length; j++)
                        {
                            if (orderingRules.GetValueOrDefault(splitArray[j], []).Contains(splitArray[i]))
                            {
                                (splitArray[j], splitArray[i]) = (splitArray[i], splitArray[j]);
                                swapped = true;
                                break;
                            }
                        }

                        if (!swapped)
                        {
                            i++;
                        }
                    }

                    count += splitArray[i - 1];
                }
            }
        }
        
        Console.WriteLine(count);
    }
}