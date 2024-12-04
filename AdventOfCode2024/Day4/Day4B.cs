namespace AdventOfCode2024.Day4;

public class Day4B : ISolver
{
    public void Solve()
    {
        var lines = File.ReadAllLines("Inputs\\day4.txt");

        var count = 0;
        for (var y = 1; y < lines.Length - 1; y++)
        {
            for (var x = 1; x < lines[0].Length - 1; x++)
            {
                if (lines[y][x] != 'A')
                {
                    continue;
                }

                char[] chars1 = [lines[y - 1][x - 1], lines[y][x], lines[y + 1][x + 1]];
                char[] chars2 = [lines[y - 1][x + 1], lines[y][x], lines[y + 1][x - 1]];
                
                var string1 = new string(chars1);
                var string2 = new string(chars2);
                if ((string1 is "SAM" or "MAS") && (string2 is "SAM" or "MAS"))
                {
                    count++;
                }
            }
        }
        
        Console.WriteLine(count);
    }
}