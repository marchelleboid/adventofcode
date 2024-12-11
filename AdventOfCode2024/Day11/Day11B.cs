namespace AdventOfCode2024.Day11;

public class Day11B : ISolver
{
    private readonly Dictionary<(string, int), ulong> _cache = new();
    
    public void Solve()
    {
        var line = File.ReadAllLines("Inputs\\day11.txt")[0].Split(" ");
        
        var count = line.Aggregate(0UL, (current, stone) => current + EvolveStone(stone, 75));

        Console.WriteLine(count);
    }

    private ulong EvolveStone(string stone, int blinks)
    {
        if (_cache.ContainsKey((stone, blinks)))
        {
            return _cache[(stone, blinks)];
        }
        
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

        var result = blinks switch
        {
            1 => (ulong)evolved.Count,
            _ => evolved.Aggregate(0UL, (current, stone2) => current + EvolveStone(stone2, blinks - 1))
        };
        _cache.Add((stone, blinks), result);
        return result;
    }
}