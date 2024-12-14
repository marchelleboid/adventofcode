using System.Text.RegularExpressions;

namespace AdventOfCode2024.Day14;

public class Day14B : ISolver
{
    private const int MaxX = 101;
    private const int MaxY = 103;

    class Robot(int x, int y, int vX, int vY)
    {
        public int X { get; set; } = x;
        public int Y { get; set; } = y;
        public int Vx { get; } = vX;
        public int Vy { get; } = vY;
    }

    public void Solve()
    {
        var lines = File.ReadLines("Inputs\\day14.txt");
        
        var robots = new HashSet<Robot>();
        
        var lineRegex = new Regex(@"p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)");
        foreach (var line in lines)
        {
            var match = lineRegex.Match(line);
            var pX = int.Parse(match.Groups[1].Value);
            var pY = int.Parse(match.Groups[2].Value);
            var vX = int.Parse(match.Groups[3].Value);
            var vY = int.Parse(match.Groups[4].Value);
            
            robots.Add(new Robot(pX, pY, vX, vY));
        }
        
        for (var i = 1; i < 10000; i++)
        {
            foreach (var robot in robots)
            {
                robot.X = Mod2(robot.X + robot.Vx, MaxX);
                robot.Y = Mod2(robot.Y + robot.Vy, MaxY);
            }
            
            // Rider kept crashing after too many WriteLines
            if (i > 5320 && (i - 68) % 101 == 0)
            {
                Console.WriteLine("Second: " + i);
                for (var y = 0; y < MaxY; y++)
                {
                    for (var x = 0; x < MaxX; x++)
                    {
                        Console.Write(robots.Any(robot => robot.X == x && robot.Y == y) ? '#' : '.');
                    }

                    Console.WriteLine();
                }
                
                Console.ReadLine();
            }
        }
    }

    private static int Mod2(int x, int m)
    {
        return (x % m + m) % m;
    }
    
    
}