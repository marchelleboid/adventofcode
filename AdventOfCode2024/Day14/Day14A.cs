using System.Text.RegularExpressions;

namespace AdventOfCode2024.Day14;

public class Day14A : ISolver
{
    public void Solve()
    {
        var lines = File.ReadAllLines("Inputs\\day14.txt");

        const int maxX = 101;
        const int maxY = 103;

        var robots = new List<(int, int)>();
        
        var lineRegex = new Regex(@"p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)");
        foreach (var line in lines)
        {
            var match = lineRegex.Match(line);
            var pX = int.Parse(match.Groups[1].Value);
            var pY = int.Parse(match.Groups[2].Value);
            var vX = int.Parse(match.Groups[3].Value);
            var vY = int.Parse(match.Groups[4].Value);

            var finalX = Mod2(pX + 100 * vX, maxX);
            var finalY = Mod2(pY + 100 * vY, maxY);
            
            robots.Add((finalX, finalY));
        }

        var upperLeft = 0;
        var upperRight = 0;
        var lowerLeft = 0;
        var lowerRight = 0;
        foreach (var robot in robots)
        {
            if (robot.Item1 < maxX / 2)
            {
                if (robot.Item2 < maxY / 2)
                {
                    upperLeft++;
                }
                else if (robot.Item2 > maxY / 2)
                {
                    lowerLeft++;
                }
            }
            else if (robot.Item1 > maxX / 2)
            {
                if (robot.Item2 < maxY / 2)
                {
                    upperRight++;
                }
                else if (robot.Item2 > maxY / 2)
                {
                    lowerRight++;
                }
            }
        }
        
        Console.WriteLine(upperLeft * upperRight * lowerLeft * lowerRight);
    }

    private static int Mod2(int x, int m)
    {
        return (x % m + m) % m;
    }
}