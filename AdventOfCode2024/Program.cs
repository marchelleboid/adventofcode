using AdventOfCode2024;
using AdventOfCode2024.Day1;
using AdventOfCode2024.Day2;

ISolver solver = args[0] switch
{
    "1a" => new Day1A(),
    "1b" => new Day1B(),
    "2a" => new Day2A(),
    "2b" => new Day2B(),
    _ => throw new ArgumentException($"Unknown day: {args[0]}"),
};

solver.Solve();
