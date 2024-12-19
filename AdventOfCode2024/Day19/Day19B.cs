namespace AdventOfCode2024.Day19;

public class Day19B : ISolver
{
    private readonly Dictionary<string, long> _cache = new();
    
    public void Solve()
    {
        var lines = File.ReadAllLines("Inputs\\day19.txt");
        var patterns = new List<string>(lines.First().Split(", ")).OrderBy(x => x.Length).ToList();;

        var count = lines.Skip(2).Sum(line => CountDesigns(line, patterns));
        Console.WriteLine(count);
    }
    
    private long CountDesigns(string line, List<string> patterns)
    {
        if (_cache.ContainsKey(line))
        {
            return _cache[line];
        }
        
        if (line.Length == 0)
        {
            return 1L;
        }

        var result = patterns.Where(line.StartsWith).Sum(pattern => CountDesigns(line[pattern.Length..], patterns));
        _cache.Add(line, result);
        return result;
    }
}