using System.Text.RegularExpressions;

namespace AdventOfCode2024.Day13;

public class Day13B : ISolver
{
    private readonly Regex _buttonRegex = new Regex(@"Button [AB]: X\+(\d+), Y\+(\d+)");
    private readonly Regex _prizeRegex = new Regex(@"Prize: X=(\d+), Y=(\d+)");
    
    public void Solve()
    {
        var lines = File.ReadLines("Inputs\\day13.txt");

        var parsedA = false;
        var parsedB = false;

        var x1 = 0.0;
        var y1 = 0.0;
        
        var x2 = 0.0;
        var y2 = 0.0;

        var tokens = 0UL;
        foreach (var line in lines)
        {
            if (!parsedA)
            {
                var match = _buttonRegex.Match(line);
                x1 = double.Parse(match.Groups[1].Value);
                y1 = double.Parse(match.Groups[2].Value);
                parsedA = true;
            }
            else if (!parsedB)
            {
                var match = _buttonRegex.Match(line);
                x2 = double.Parse(match.Groups[1].Value);
                y2 = double.Parse(match.Groups[2].Value);
                parsedB = true;
            }
            else if (line.Length != 0)
            {
                var match = _prizeRegex.Match(line);
                var prizeX = double.Parse(match.Groups[1].Value) + 10000000000000.0;
                var prizeY = double.Parse(match.Groups[2].Value) + 10000000000000.0;
                tokens += SolveEquation(x1, y1, x2, y2, prizeX, prizeY);
            }
            else
            {
                parsedA = false;
                parsedB = false;
            }
        }
        
        Console.WriteLine(tokens);
    }

    private static ulong SolveEquation(double x1, double y1, double x2, double y2, double prizeX, double prizeY)
    {
        var a = ((y2 * prizeX) / x2 - prizeY) / ((y2 * x1) / x2 - y1);
        var b = (prizeX - x1 * a) / x2;
        
        if (IsProbablyInteger(a) && IsProbablyInteger(b))
        {
            return 3UL * (ulong) Math.Round(a) + (ulong) Math.Round(b);
        }

        return 0UL;
    }

    private static bool IsProbablyInteger(double value)
    {
        return Math.Abs(value - Math.Round(value)) < 0.0001;
    }
}