using System.Text.RegularExpressions;

namespace AdventOfCode2024.Day3;

public class Day3A : ISolver
{
    public void Solve()
    {
        var lines = File.ReadLines("Inputs\\day3.txt");
        const string pattern = @"(mul\((\d+),(\d+)\))";
        
        var regex = new Regex(pattern, RegexOptions.IgnoreCase);
        
        var total = 0;

        foreach (var line in lines)
        {
            var match = regex.Match(line);
            while (match.Success)
            {
                var first = int.Parse(match.Groups[2].Value);
                var second = int.Parse(match.Groups[3].Value);

                total += first * second;

                match = match.NextMatch();
            }
        }

        Console.WriteLine(total);
    }
}