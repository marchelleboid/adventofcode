namespace AdventOfCode2024.Day2;

public class Day2A : ISolver
{
    public void Solve()
    {
        var safeReports = 0;
        
        var lines = File.ReadLines("Inputs\\day2.txt");
        foreach (var line in lines)
        {
            var splitLine = line.Split(" ").Select(int.Parse).ToList();
            var list2 = splitLine.Skip(1).ToList();
            var differences = splitLine.Zip(list2, (a, b) => a - b).ToList();
            if (differences.First() > 0)
            {
                if (differences.All(d => d is >= 1 and <= 3))
                {
                    safeReports++;
                }
            }
            else if (differences.First() < 0)
            {
                if (differences.All(d => d is >= -3 and <= -1))
                {
                    safeReports++;
                }
            }
        }
        
        Console.WriteLine(safeReports);
    }
}