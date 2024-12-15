namespace AdventOfCode2024.Day15;

public class Day15A : ISolver
{
    public void Solve()
    {
        var lines = File.ReadAllLines("Inputs\\day15.txt");

        var robot = (0, 0);
        var walls = new HashSet<(int, int)>();
        var boxes = new HashSet<(int, int)>();

        var readingGrid = true;

        var moves = "";

        for (var y = 0; y < lines.Length; y++)
        {
            if (lines[y].Length == 0)
            {
                readingGrid = false;
            }
            else if (readingGrid) 
            {
                for (var x = 0; x < lines[0].Length; x++)
                {
                    switch (lines[y][x])
                    {
                        case '#':
                            walls.Add((x, y));
                            break;
                        case 'O':
                            boxes.Add((x, y));
                            break;
                        case '@':
                            robot = (x, y);
                            break;
                    }
                }
            }
            else
            {
                moves += lines[y].Trim();
            }
        }
        
        var maxX = lines[0].Length;
        var maxY = lines.Length;

        foreach (var move in moves)
        {
            switch (move)
            {
                case '^':
                    if (walls.Contains((robot.Item1, robot.Item2 - 1)))
                    {
                        continue;
                    }

                    if (boxes.Contains((robot.Item1, robot.Item2 - 1)))
                    {
                        for (var y = robot.Item2 - 2; y > 0; y--)
                        {
                            if (walls.Contains((robot.Item1, y)))
                            {
                                break;
                            }

                            if (boxes.Contains((robot.Item1, y)))
                            {
                                continue;
                            }
                            boxes.Remove((robot.Item1, robot.Item2 - 1));
                            robot = (robot.Item1, robot.Item2 - 1);
                            boxes.Add((robot.Item1, y));
                            break;
                        }
                    }
                    else
                    {
                        robot = (robot.Item1, robot.Item2 - 1);
                    }
                    break;
                case 'v':
                    if (walls.Contains((robot.Item1, robot.Item2 + 1)))
                    {
                        continue;
                    }

                    if (boxes.Contains((robot.Item1, robot.Item2 + 1)))
                    {
                        for (var y = robot.Item2 + 2; y < maxY; y++)
                        {
                            if (walls.Contains((robot.Item1, y)))
                            {
                                break;
                            }

                            if (boxes.Contains((robot.Item1, y)))
                            {
                                continue;
                            }
                            boxes.Remove((robot.Item1, robot.Item2 + 1));
                            robot = (robot.Item1, robot.Item2 + 1);
                            boxes.Add((robot.Item1, y));
                            break;
                        }
                    }
                    else
                    {
                        robot = (robot.Item1, robot.Item2 + 1);
                    }
                    break;
                case '>':
                    if (walls.Contains((robot.Item1 + 1, robot.Item2)))
                    {
                        continue;
                    }

                    if (boxes.Contains((robot.Item1 + 1, robot.Item2)))
                    {
                        for (var x = robot.Item1 + 2; x < maxX; x++)
                        {
                            if (walls.Contains((x, robot.Item2)))
                            {
                                break;
                            }

                            if (boxes.Contains((x, robot.Item2)))
                            {
                                continue;
                            }
                            boxes.Remove((robot.Item1 + 1, robot.Item2));
                            robot = (robot.Item1 + 1, robot.Item2);
                            boxes.Add((x, robot.Item2));
                            break;
                        }
                    }
                    else
                    {
                        robot = (robot.Item1 + 1, robot.Item2);
                    }
                    break;
                case '<':
                    if (walls.Contains((robot.Item1 - 1, robot.Item2)))
                    {
                        continue;
                    }

                    if (boxes.Contains((robot.Item1 - 1, robot.Item2)))
                    {
                        for (var x = robot.Item1 - 2; x > 0; x--)
                        {
                            if (walls.Contains((x, robot.Item2)))
                            {
                                break;
                            }

                            if (boxes.Contains((x, robot.Item2)))
                            {
                                continue;
                            }
                            boxes.Remove((robot.Item1 - 1, robot.Item2));
                            robot = (robot.Item1 - 1, robot.Item2);
                            boxes.Add((x, robot.Item2));
                            break;
                        }
                    }
                    else
                    {
                        robot = (robot.Item1 - 1, robot.Item2);
                    }
                    break;
            }
        }
        
        var count = boxes.Sum(box => (100 * box.Item2 + box.Item1));
        Console.WriteLine(count);
    }
}