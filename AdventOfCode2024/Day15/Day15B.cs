namespace AdventOfCode2024.Day15;

public class Day15B : ISolver
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
                            walls.Add((2 * x, y));
                            walls.Add((2 * x + 1, y));
                            break;
                        case 'O':
                            boxes.Add((2 * x, y));
                            break;
                        case '@':
                            robot = (2 * x, y);
                            break;
                    }
                }
            }
            else
            {
                moves += lines[y].Trim();
            }
        }
        
        var maxX = 2 * lines[0].Length;
        
        foreach (var move in moves)
        {
            switch (move)
            {
                case '^':
                    if (walls.Contains((robot.Item1, robot.Item2 - 1)))
                    {
                        continue;
                    }

                    if (boxes.Contains((robot.Item1, robot.Item2 - 1)) ||
                        boxes.Contains((robot.Item1 - 1, robot.Item2 - 1)))
                    {
                        var cancel = false;
                        var boxesToMove = new List<(int, int)>
                        {
                            boxes.Contains((robot.Item1, robot.Item2 - 1))
                                ? (robot.Item1, robot.Item2 - 1)
                                : (robot.Item1 - 1, robot.Item2 - 1)
                        };
                        var boxQueue = new Queue<(int, int)>(boxesToMove);
                        while (boxQueue.Count > 0)
                        {
                            var box = boxQueue.Dequeue();
                            if (walls.Contains((box.Item1, box.Item2 - 1)) ||
                                walls.Contains((box.Item1 + 1, box.Item2 - 1)))
                            {
                                cancel = true;
                                break;
                            }

                            if (boxes.Contains((box.Item1, box.Item2 - 1)))
                            {
                                boxQueue.Enqueue((box.Item1, box.Item2 - 1));
                                boxesToMove.Add((box.Item1, box.Item2 - 1));
                            }

                            if (boxes.Contains((box.Item1 - 1, box.Item2 - 1)))
                            {
                                boxQueue.Enqueue((box.Item1 - 1, box.Item2 - 1));
                                boxesToMove.Add((box.Item1 - 1, box.Item2 - 1));
                            }
                            
                            if (boxes.Contains((box.Item1 + 1, box.Item2 - 1)))
                            {
                                boxQueue.Enqueue((box.Item1 + 1, box.Item2 - 1));
                                boxesToMove.Add((box.Item1 + 1, box.Item2 - 1));
                            }
                        }

                        if (!cancel)
                        {
                            robot = (robot.Item1, robot.Item2 - 1);
                            foreach (var boxToMove in boxesToMove)
                            {
                                boxes.Remove((boxToMove.Item1, boxToMove.Item2));
                            }

                            foreach (var boxToMove in boxesToMove)
                            {
                                boxes.Add((boxToMove.Item1, boxToMove.Item2 - 1));
                            }
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

                    if (boxes.Contains((robot.Item1, robot.Item2 + 1)) ||
                        boxes.Contains((robot.Item1 - 1, robot.Item2 + 1)))
                    {
                        var cancel = false;
                        var boxesToMove = new List<(int, int)>
                        {
                            boxes.Contains((robot.Item1, robot.Item2 + 1))
                                ? (robot.Item1, robot.Item2 + 1)
                                : (robot.Item1 - 1, robot.Item2 + 1)
                        };
                        var boxQueue = new Queue<(int, int)>(boxesToMove);
                        while (boxQueue.Count > 0)
                        {
                            var box = boxQueue.Dequeue();
                            if (walls.Contains((box.Item1, box.Item2 + 1)) ||
                                walls.Contains((box.Item1 + 1, box.Item2 + 1)))
                            {
                                cancel = true;
                                break;
                            }

                            if (boxes.Contains((box.Item1, box.Item2 + 1)))
                            {
                                boxQueue.Enqueue((box.Item1, box.Item2 + 1));
                                boxesToMove.Add((box.Item1, box.Item2 + 1));
                            }

                            if (boxes.Contains((box.Item1 - 1, box.Item2 + 1)))
                            {
                                boxQueue.Enqueue((box.Item1 - 1, box.Item2 + 1));
                                boxesToMove.Add((box.Item1 - 1, box.Item2 + 1));
                            }
                            
                            if (boxes.Contains((box.Item1 + 1, box.Item2 + 1)))
                            {
                                boxQueue.Enqueue((box.Item1 + 1, box.Item2 + 1));
                                boxesToMove.Add((box.Item1 + 1, box.Item2 + 1));
                            }
                        }

                        if (!cancel)
                        {
                            robot = (robot.Item1, robot.Item2 + 1);
                            foreach (var boxToMove in boxesToMove)
                            {
                                boxes.Remove((boxToMove.Item1, boxToMove.Item2));
                            }

                            foreach (var boxToMove in boxesToMove)
                            {
                                boxes.Add((boxToMove.Item1, boxToMove.Item2 + 1));
                            }
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
                        var boxesToMove = new List<(int, int)> { (robot.Item1 + 1, robot.Item2) };
                        for (var x = robot.Item1 + 3; x < maxX; x += 2)
                        {
                            if (walls.Contains((x, robot.Item2)))
                            {
                                if (walls.Contains((x - 1, robot.Item2)) ||
                                    boxes.Contains((x - 2, robot.Item2)))
                                {
                                    break;
                                }
                            }

                            if (boxes.Contains((x, robot.Item2)))
                            {
                                boxesToMove.Add((x, robot.Item2));
                                continue;
                            }
                            robot = (robot.Item1 + 1, robot.Item2);
                            foreach (var boxToMove in boxesToMove)
                            {
                                boxes.Remove((boxToMove.Item1, boxToMove.Item2));
                                boxes.Add((boxToMove.Item1 + 1, boxToMove.Item2));
                            }
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

                    if (boxes.Contains((robot.Item1 - 2, robot.Item2)))
                    {
                        var boxesToMove = new List<(int, int)> { (robot.Item1 - 2, robot.Item2) };
                        for (var x = robot.Item1 - 4; x > 0; x -= 2)
                        {
                            if (walls.Contains((x, robot.Item2)))
                            {
                                if (walls.Contains((x + 1, robot.Item2)) ||
                                    boxes.Contains((x + 1, robot.Item2)))
                                {
                                    break;
                                }
                            }

                            if (boxes.Contains((x, robot.Item2)))
                            {
                                boxesToMove.Add((x, robot.Item2));
                                continue;
                            }
                            robot = (robot.Item1 - 1, robot.Item2);
                            foreach (var boxToMove in boxesToMove)
                            {
                                boxes.Remove((boxToMove.Item1, boxToMove.Item2));
                                boxes.Add((boxToMove.Item1 - 1, boxToMove.Item2));
                            }
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