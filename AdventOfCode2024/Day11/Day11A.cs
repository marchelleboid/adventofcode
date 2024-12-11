namespace AdventOfCode2024.Day11;

public class Day11A : ISolver
{
    public void Solve()
    {
        var line = File.ReadAllLines("Inputs\\day11.txt")[0].Split(" ");

        var currentLine = line.ToList();
        var blinksLeft = 25;
        while (blinksLeft > 0)
        {
            var newLine = new List<string>();
            foreach (var stone in currentLine)
            {
                newLine.AddRange(EvolveStone(stone));
            }
            currentLine = newLine;
            blinksLeft--;
        }
        Console.WriteLine(currentLine.Count);
    }

    private IEnumerable<string> EvolveStone(string stone)
    {
        var evolved = new List<string>();
        if (stone == "0")
        {
            evolved.Add("1");
        }
        else if (stone.Length % 2 == 0)
        {
            evolved.Add(ulong.Parse(stone[..(stone.Length / 2)]).ToString());
            evolved.Add(ulong.Parse(stone[(stone.Length / 2)..]).ToString());
        }
        else
        {
            evolved.Add((ulong.Parse(stone) * 2024UL).ToString());
        }
        
        return evolved;
    }
}