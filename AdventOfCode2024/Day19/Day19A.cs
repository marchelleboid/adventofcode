namespace AdventOfCode2024.Day19;

public class Day19A : ISolver
{
    private readonly Dictionary<string, bool> _cache = new();
    
    public void Solve()
    {
        var lines = File.ReadAllLines("Inputs\\day19.txt");
        var patterns = new List<string>(lines.First().Split(", ")).OrderBy(x => x.Length).ToList();;

        var count = lines.Skip(2).Count(line => IsPossibleDesign(line, patterns));
        Console.WriteLine(count);
    }
    
    private bool IsPossibleDesign(string line, List<string> patterns)
    {
        if (_cache.ContainsKey(line))
        {
            return _cache[line];
        }
        
        if (!line.Contains('g'))
        {
            return true;
        }

        var result = patterns.Where(line.StartsWith).Any(pattern => IsPossibleDesign(line[pattern.Length..], patterns));
        _cache.Add(line, result);
        return result;
    }
}