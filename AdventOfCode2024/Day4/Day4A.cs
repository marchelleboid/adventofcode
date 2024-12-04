namespace AdventOfCode2024.Day4;

public class Day4A : ISolver
{
    public void Solve()
    {
        var lines = File.ReadAllLines("Inputs\\day4.txt");
        
        var maxX = lines[0].Length;
        var maxY = lines.Length;

        var count = 0;
        for (var y = 0; y < lines.Length; y++)
        {
            for (var x = 0; x < lines[0].Length; x++)
            {
                if (lines[y][x] != 'X')
                {
                    continue;
                }
                
                if (x < maxX - 3)
                {
                    if (lines[y][x + 1] == 'M' && lines[y][x + 2] == 'A' && lines[y][x + 3] == 'S')
                    {
                        count++;
                    }
                    
                    if (y < maxY - 3)
                    {
                        if (lines[y + 1][x + 1] == 'M' && lines[y + 2][x + 2] == 'A' && lines[y + 3][x + 3] == 'S')
                        {
                            count++;
                        }
                    }

                    if (y > 2)
                    {
                        if (lines[y - 1][x + 1] == 'M' && lines[y - 2][x + 2] == 'A' && lines[y - 3][x + 3] == 'S')
                        {
                            count++;
                        }
                    }
                }

                if (x > 2)
                {
                    if (lines[y][x - 1] == 'M' && lines[y][x - 2] == 'A' && lines[y][x - 3] == 'S')
                    {
                        count++;
                    }
                    
                    if (y < maxY - 3)
                    {
                        if (lines[y + 1][x - 1] == 'M' && lines[y + 2][x - 2] == 'A' && lines[y + 3][x - 3] == 'S')
                        {
                            count++;
                        }
                    }

                    if (y > 2)
                    {
                        if (lines[y - 1][x - 1] == 'M' && lines[y - 2][x - 2] == 'A' && lines[y - 3][x - 3] == 'S')
                        {
                            count++;
                        }
                    }
                }

                if (y < maxY - 3)
                {
                    if (lines[y + 1][x] == 'M' && lines[y + 2][x] == 'A' && lines[y + 3][x] == 'S')
                    {
                        count++;
                    }
                }

                if (y > 2)
                {
                    if (lines[y - 1][x] == 'M' && lines[y - 2][x] == 'A' && lines[y - 3][x] == 'S')
                    {
                        count++;
                    }
                }
            }
        }
        
        Console.WriteLine(count);
    }
}