namespace AdventOfCode2024.Day2;

public class Day2B : ISolver
{
    private static bool IsSafe(List<int> report)
    {
        var list2 = report.Skip(1).ToList();
        var differences = report.Zip(list2, (a, b) => a - b).ToList();
        return differences.First() switch
        {
            > 0 => differences.All(d => d is >= 1 and <= 3),
            < 0 => differences.All(d => d is >= -3 and <= -1),
            _ => false
        };
    }
    
    public void Solve()
    {
        var safeReports = 0;
        
        var lines = File.ReadLines("Inputs\\day2.txt");
        foreach (var line in lines)
        {
            var splitLine = line.Split(" ").Select(int.Parse).ToList();
            if (IsSafe(splitLine))
            {
                safeReports++;
            }
            else
            {
                for (var i = 0; i < splitLine.Count; i++)
                {
                    var copied = new List<int>(splitLine);
                    copied.RemoveAt(i);
                    if (IsSafe(copied))
                    {
                        safeReports++;
                        break;
                    }
                }
            }
        }
        
        Console.WriteLine(safeReports);
    }
}