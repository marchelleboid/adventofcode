using System.Text.RegularExpressions;

namespace AdventOfCode2024.Day3;

public class Day3B : ISolver
{
    public void Solve()
    {
        var lines = File.ReadLines("Inputs\\day3.txt");
        const string pattern = @"(mul\((\d+),(\d+)\))|(do\(\))|(don\'t\(\))";
        
        var regex = new Regex(pattern, RegexOptions.IgnoreCase);
        
        var total = 0;
        var enabled = true;

        foreach (var line in lines)
        {
            var match = regex.Match(line);
            while (match.Success)
            {
                if (match.Value.StartsWith("mul"))
                {
                    if (enabled)
                    {
                        var first = int.Parse(match.Groups[2].Value);
                        var second = int.Parse(match.Groups[3].Value);

                        total += first * second;
                    }
                } 
                else if (match.Value.StartsWith("do()"))
                {
                    enabled = true;
                } 
                else if (match.Value.StartsWith("don't()"))
                {
                    enabled = false;
                }

                match = match.NextMatch();
            }
        }

        Console.WriteLine(total);
    }
}