using AdventOfCode2024;
using AdventOfCode2024.Day1;
using AdventOfCode2024.Day2;
using AdventOfCode2024.Day3;
using AdventOfCode2024.Day4;
using AdventOfCode2024.Day5;
using AdventOfCode2024.Day6;
using AdventOfCode2024.Day7;
using AdventOfCode2024.Day8;
using AdventOfCode2024.Day9;

ISolver solver = args[0] switch
{
    "1a" => new Day1A(),
    "1b" => new Day1B(),
    "2a" => new Day2A(),
    "2b" => new Day2B(),
    "3a" => new Day3A(),
    "3b" => new Day3B(),
    "4a" => new Day4A(),
    "4b" => new Day4B(),
    "5a" => new Day5A(),
    "5b" => new Day5B(),
    "6a" => new Day6A(),
    "6b" => new Day6B(),
    "7a" => new Day7A(),
    "7b" => new Day7B(),
    "8a" => new Day8A(),
    "8b" => new Day8B(),
    "9a" => new Day9A(),
    "9b" => new Day9B(),
    _ => throw new ArgumentException($"Unknown day: {args[0]}"),
};

solver.Solve();
