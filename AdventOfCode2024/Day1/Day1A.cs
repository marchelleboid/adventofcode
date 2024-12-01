namespace AdventOfCode2024.Day1;

public class Day1A : ISolver
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

        list1.Sort();
        list2.Sort();

        Console.WriteLine(list1.Zip(list2, (a, b) => Math.Abs(a - b)).Sum());
    }
}
