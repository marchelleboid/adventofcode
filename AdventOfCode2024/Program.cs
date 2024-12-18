using AdventOfCode2024;
using AdventOfCode2024.Day1;
using AdventOfCode2024.Day10;
using AdventOfCode2024.Day11;
using AdventOfCode2024.Day12;
using AdventOfCode2024.Day13;
using AdventOfCode2024.Day14;
using AdventOfCode2024.Day15;
using AdventOfCode2024.Day16;
using AdventOfCode2024.Day17;
using AdventOfCode2024.Day18;
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
    "10a" => new Day10A(),
    "10b" => new Day10B(),
    "11a" => new Day11A(),
    "11b" => new Day11B(),
    "12a" => new Day12A(),
    "12b" => new Day12B(),
    "13a" => new Day13A(),
    "13b" => new Day13B(),
    "14a" => new Day14A(),
    "14b" => new Day14B(),
    "15a" => new Day15A(),
    "15b" => new Day15B(),
    "16a" => new Day16A(),
    "16b" => new Day16B(),
    "17a" => new Day17A(),
    "17b" => new Day17B(),
    "18a" => new Day18A(),
    "18b" => new Day18B(),
    _ => throw new ArgumentException($"Unknown day: {args[0]}"),
};

solver.Solve();
