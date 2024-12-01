using System.Collections.Immutable;

namespace AdventOfCode2024.Day1;

public class Day1B : ISolver
{
    public void Solve()
    {
        var list1 = new List<int>();
        var list2 = new List<int>();
        
        var lines = File.ReadLines("Inputs\\day1.txt");
        foreach (var line in lines)
        {
            var splitLine = line.Split("   ");
            list1.Add(int.Parse(splitLine[0]));
            list2.Add(int.Parse(splitLine[1]));
        }

        var counts = list2.GroupBy(i => i).ToImmutableDictionary(group => group.Key, group => group.Count());

        var similarity = list1.Sum(i => i * counts.GetValueOrDefault(i, 0));

        Console.WriteLine(similarity);
    }
}
