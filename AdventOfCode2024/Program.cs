using AdventOfCode2024;
using AdventOfCode2024.Day1;

ISolver solver = args[0] switch
{
    "1a" => new Day1A(),
    "1b" => new Day1B(),
    _ => throw new ArgumentException($"Unknown day: {args[0]}"),
};

solver.Solve();
